
const functions = require('firebase-functions');
const admin = require('firebase-admin');
const nodemailer =require('nodemailer');



admin.initializeApp();
// const db = getFirestore();

var transporter = nodemailer.createTransport({
    host:'smtp.gmail.com',
    port:465,
    secure:true,
    auth:{
        user:'ashsocialnet@gmail.com',
        pass:'gclncodicikszzra'
    }
});

// const users_db = db.collection('users');





exports.sendEmail = functions.firestore.document('messages/{docId}')
.onCreate(async (snap,context)=>{
    const data=snap.data();
    const errors = [];

    
        
    const userSnapshots = await admin.firestore().collection('users').get();
    var users = userSnapshots.docs.map(snap => snap.data().email);


    if (users.length == 0) {
        console.log("No users yet");
        return
    }

    var x  = users.length - 1;

    for( let i = 0; i < users.length - 1; i++) {

        if (users.at(i) == data['sender-email']) {
            continue;
        }

        const mailOptions = {
            from: `ashsocialnet@gmail.com`,
            // to: snap.data().email,
            to:`${users.at(i)}`,
            subject: 'Ashesi Notification',
            text:`Hi!\n${data['sender-name']} made a post on Ashesi Social Network.\nGo and check it out\n\nRegards,\nASN Admin`,
        };

        transporter.sendMail(mailOptions, (error, data) => {
            if (error) {
                console.log(error)
                errors.push(error)
            }
        });
    }

    const mailOptions = {
        from: `ashsocialnet@gmail.com`,
        // to: snap.data().email,
        to:`${users.at(x)}`,
        subject: 'Ashesi Notification',
        text:`Hi!\n${data['sender-name']} made a post on Ashesi Social Network.\nGo and check it out\n\nRegards,\nASN Admin`,
    };

    return transporter.sendMail(mailOptions, (error, data) => {
        if (error) {
            console.log(error)
            return
        }
        console.log("Sent!");
        return data;
    });
});
    
