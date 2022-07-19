import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import * as moment from 'moment';
admin.initializeApp();

const db = admin.firestore();
const fcm = admin.messaging();

interface IToken {
    uid: string
    token: string
}

interface IPref {
    uid: string
    start: number
    defaultCycleLength: number
}

enum Flow {
    Light,
    Normal,
    Heavy
}

interface INote {
    uid: string;
    periodStart: boolean;
    flow: Flow;
    date: Date;
}

export const sendNotificationsHttp = functions.https.onRequest(async (req, res) => {
    await sendNotifications();

    res.end();
});


export const sendNotificationsScheduler = functions.pubsub.schedule('0 * * * *').onRun(async () => {
    await sendNotifications();

    return null;
});

const sendNotifications = async () => {
    const tokens: IToken[] = [];
    const prefs: IPref[] = [];

    await db.collection('tokens').get().then((snapshot) => {
        snapshot.forEach((document) => {
            tokens.push({
                uid: document.id,
                token: document.get('token'),
            });
        });
    });

    await db.collection('preferences').get().then((snapshot) => {
        snapshot.forEach((document) => {
            prefs.push({
                uid: document.id,
                start: document.get('start')?.toDate(),
                defaultCycleLength: document.get('defaultCycleLength'),
            });
        });
    });


    tokens.forEach(async (token) => {
        await prefs.forEach(async (pref) => {
            if (token.uid === pref.uid) {
                const notes: INote[] = [];

                await db.collection('notes').where('uid', '==', pref.uid).get().then((snapshot) => {
                    snapshot.forEach((document) => {
                        notes.push({
                            uid: document.get('uid'),
                            periodStart: document.get('periodStart'),
                            date: document.get('date')?.toDate(),
                            flow: document.get('flow'),
                        });
                    });
                });

                const current = moment(`2000 1 1 ${(new Date).getHours()}:00:00`);
                const start = (new Date(pref.start));
                let payload: admin.messaging.MessagingPayload | undefined = undefined;

                console.log(start, current);

                if (start.getHours() === current.hour()) {
                    const periodStarts = computePeriodStarts(notes);
                    const cycleLength = computeMenstrualLength(pref.defaultCycleLength, periodStarts);
                    const nextPeriod = computeNextPeriodStart(cycleLength, periodStarts);

                    if (determineIfSendNotification(nextPeriod)) {
                        payload = {
                            notification: {
                                title: 'Good Morning!',
                                body: 'Your next period is starting soon.',
                            },
                        };
                    }
                }

                if (payload) {
                    fcm.sendToDevice(token.token, payload);
                }
            }
        });
    });
};

const computePeriodStarts = (notes: INote[]) => {
    return notes.filter((note) => note.periodStart).map((note) => note.date);
};

const computeMenstrualLength = (defaultCycleLength: number, periodStarts: Date[]) => {
    if (periodStarts.length < 3) {
        return defaultCycleLength;
    }

    periodStarts.sort((a, b) => a < b ? 1 : b < a ? -1 : 0);

    let temp = periodStarts[0];
    let sum = 0;

    for (let i = 1; i < periodStarts.length - 1; ++i) {
        sum += moment(periodStarts[i]).diff(temp);
        temp = periodStarts[i];
    }

    return Math.ceil(sum / (periodStarts.length - 2));
};

const computeNextPeriodStart = (cycleLength: number, periodStarts: Date[]) => {
    periodStarts.sort((a, b) => a < b ? 1 : b < a ? -1 : 0);

    return moment(periodStarts[periodStarts.length - 1]).add(cycleLength, 'days').toDate();
};

const determineIfSendNotification = (date: Date) => {
    const today = new Date();
    const difference = moment(today).diff(date);

    return difference < 4 && difference > 0;
};
