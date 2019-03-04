const sgMail = require('@sendgrid/mail');
// const config = require('./config/sendgrid')


methods = {
 'send' : () => {

    // sgMail.setApiKey(config.SENDGRID_API_KEY);
    const msg = {
        to: 'rishabh.gupta@cygrp.com',
        from: 'rishabh.gupta@cygrp.com',
        subject: 'Sending Sample Leave Mail',
        text: 'One of your team members is requiring a leave',
        html: '<strong>Hrms</strong>'
        // mail_settings: {
        //   sandbox_mode: {
        //     enable: true
        //   }
        // },
      };
    return sgMail.send(msg)
 }
}
module.exports = methods

