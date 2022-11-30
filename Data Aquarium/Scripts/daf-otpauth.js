/*!
* Data Aquarium Framework - One Time Password Authentication
* Copyright 2021-2022 Code On Time LLC; Licensed MIT; http://codeontime.com/license
*/
(function(){function o(n){n||(n=this);var t=n.fieldValue("Methods");return t!=null&&t.match(/app/)}function y(n,i){var e=n.data(),o=n.data("survey"),u,s=e.BackupCode,f={};return i==null&&(i=e.Passcode),(i==null||i.length===o.codeLength&&i.toString().match(/^\d+$/))&&(i!=null||s!=null)||(i!=null&&(u=i.replace(/\D/g,""),u!==i&&(i=u,r.execute({values:{Passcode:u},raiseCalculate:!1}))),f.error=String.format(t.Messages.EnterCode,o.codeLength)),f.value=i,f}function p(t){n.restful({url:"/oauth2/v2/auth",method:"POST",body:{request_id:s.state.request_id,timezone:Intl?Intl.DateTimeFormat().resolvedOptions().timeZone:null,consent:t},hypermedia:"redirect-uri"}).then(function(n){var t=n.href;t&&(t.match(/^http/)?v(t):location.href=n.href)}).catch(function(n){i.progress("hide");$app.touch.notify({text:n.errors[0].reason+": "+n.errors[0].message,force:!0,duration:"long"})})}function v(n){location.replace(n||location.href)}function w(){return i.settings("membership.accountManager.enabled")!==!1}function l(){return s.state&&s.state.trusted}function b(){var e=s.state,c=f.Connect.replace("XXXXX","<b>{0}<\/b>").replace("YYYYY","{1}"),y=(e.scope||"").split(/\s+|,/g),t,o,r;i.whenPageShown(function(){var u=i.pageInfo(),f=u.dataView,t=i.activePage(".app-icon-avatar"),r=n.AccountManager.avatar(n.userName(),t);t.parent().toggleClass("app-has-avatar-with-picture",r!=null);r||t.text(i.initials(n.userName()));i.whenPageCanceled(function(){a();o?(n.cookie(".oauth2",s.state.request_id,0,0,5),w()?v():n.logout(v)):p(f._survey.context.allow?"allow":"deny")})});t=["<div>",'<p style="margin-top:0">',c,"<\/p>"];l()||y.forEach(function(n){if(n&&n!="openid"){r=!0;var i=h[n];i||(i={hint:n,description:String.format("This scope is not known to {0} application.",$app.touch.appName())});i.icon||(i.icon="privacy_tip");t.push("<hr/>",'<p style="display:flex;padding: 0 1em">','<i class="material-icon" style="user-select:none">',i.icon,'<\/i> <span style="padding:0 0 0 1em;line-height:24px">',i.hint,"<\/span><\/p>")}});r&&t.push("<hr/>");t.push('<p style="display:flex;',r?"padding:0 1em":"",'">','<span class="app-avatar app-avatar-valign" ',r?'style="margin:0 -5px"':"",'><i class="app-icon-avatar"><\/i><\/span>','<span style="padding:0 1em;line-height:24px">',"<span>",f.SignedInAs," ","<\/span>","<b>",n.htmlEncode(n.userName()),"<\/b><\/span>","<\/p>");t.push("<\/div>");n.survey({context:{allow:!1},text:f.AccountAccess,text2:n.touch.appName(),topics:[{wrap:!0,questions:[{name:"Consent",mode:"static",text:!1,value:String.format(t.join(""),n.htmlEncode(e.name),n.htmlEncode(e.author)),htmlEncode:!1,required:!0,options:{textStyle:"primary",mergeWithPrevious:!0}}]}],actions:[{text:l()?u.ModalPopup.CancelButton:f.Deny,position:"after",execute:function(){return k(),!1}},{text:f.SwitchAccount,position:"after",execute:function(){return o=!0,k(),!1}}],options:{modal:{fitContent:!0,max:"xxs",always:!0},form:{max:"xs"},contentStub:!1,materialIcon:"manage_accounts",discardChangesPrompt:!1},submitText:l()?f.Continue:f.Allow,submit:"oauth2consent_allow.app",cancel:!1})}function a(){i.progress("show",{text:u.Mobile.Wait})}function k(){a();setTimeout(function(){history.go(-1)})}function d(n){var f=n.keyboardPage?i.pageInfo(n.inputPage).dataView:i.dataView(),u=f._survey,t=u&&u.context,r;t&&t.otpauth&&(r=n.value,r.length==t.codeLength&&r.match(/^\d+$/)&&(n.keyboardPage?i.goBack():n.input.blur()))}var n=$app,r=n.input,i=n.touch,g=window,c=$(document),u=Web.DataViewResources,f=u.OAuth2,s=g.__settings,tt=n.clientRect,e=n.html,it=e.tag,rt=e.div,ut=e.span,ft=e.$tag,et=e.$p,ot=e.$div,st=e.$span,ht=e.$a,ct=e.$i,lt=e.$li,at=e.$ul,h=null,nt={profile:{icon:"account_circle"},email:{icon:"email"},phone:{icon:"local_phone"},address:{icon:"home"},offline_access:{icon:"verified_user"}},t=u.TwoFA;n.otpauth||(n.otpauth={});n.otpauth.totp={login:function(r){function e(n){n!=null&&n.forEach(function(n){f.push({value:n.type+":"+n.value,text:t.GetCode[n.type]+" "+n.text})})}var f=[];if(r.verify.app&&f.push({value:"app",text:t.AuthenticatorApp}),e(r.verify.email),e(r.verify.sms),e(r.verify.call),e(r.verify.dial),!f.length){i.notify({text:"Verification methods are unavailable.",force:!0});return}n.survey({context:r,text:t.Text,text2:n.touch.appName(),values:{Method:f[0].value,TrustThisDevice:!1},questions:[{name:"Passcode",type:"text",text:t.VerificationCode,placeholder:new Array(r.codeLength+1).join("0"),length:r.codeLength,causesCalculate:!0,options:{kbd:"pin"}},{name:"Method",text:t.Method,type:"text",causesCalculate:!0,visibleWhen:f.length>1||f.length===1&&f[0].value!=="app",columns:1,items:{style:"RadioButtonList",list:f},options:{lookup:{nullValue:!1}}},{name:"VerificationCodeMethodActions",text:!1,items:{style:"Actions"},options:{mergeWithPrevious:!0},visibleWhen:function(){var n=this.fieldValue("Method");return n&&n.match(/sms|call|email/)}},{name:"TrustThisDevice",type:"bool",text:t.TrustThisDevice,items:{style:"CheckBox"},causesCalculate:!0,visibleWhen:function(){return r.canTrustThisDevice!==!1}},{name:"BackupCode",type:"text",text:t.BackupCode.Text,placeholder:t.BackupCode.Placeholder,footer:t.BackupCode.Footer,causesCalculate:!0,visibleWhen:function(){return r.canEnterBackupCode!==!1}},],options:{modal:{fitContent:!0,autoGrow:!0,max:"xs"},materialIcon:"dialpad",discardChangesPrompt:!1},actions:[{text:t.Actions.GetVerificationCode,execute:"otpauthtotp_getcode.app",position:"before",scope:"VerificationCodeMethodActions",when:function(){var n=this.fieldValue("Method");return n&&n.match(/sms|call|email/)}}],submitText:u.Mobile.Verify,submit:"otpauthtotp_submit.app",calculate:"otpauthtotp_calculate.app"})},setup:function(t){t?n.otpauth.totp._setup(t):n.login(n.userName(),"null;otpauth:totp;exec:setup;")},_setup:function(i){function r(n){if(i.status!=="ready")return!0;n||(n=this);var t=n.fieldValue("Consent");return t!=null&&t.match(/Enable/)}var s=[],v=i.backupCodes&&i.backupCodes.length?i.backupCodes:null,f={Consent:"Enable",AppConfig:"ScanQrCode",Url:i.url,EnterSetupKey:i.secret,BackupCodes:v?v.join(", "):null,Methods:i.methods?i.methods.replace(/\s+/g,""):null,Status:i.status},e=[],h=i.setup.authenticators,l=i.setup.methods,c,a;if(!f.Methods&&l){c=[];for(a in l)l[a]&&c.push(a);c.length&&(f.Methods=c.join(","))}h&&(Array.isArray(h)||(h=[h]),h.forEach(function(n){n.name&&n.url&&e.push({value:n.url,text:n.name})}));e.length||e.push({value:"https://apps.apple.com/us/app/google-authenticator/id388497605",text:"Google Authenticator (iOS)"},{value:"https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2",text:"Google Authenticator (Android)"},{value:"https://apps.apple.com/us/app/microsoft-authenticator/id983156458",text:"Microsoft Authenticator (iOS)"},{value:"https://play.google.com/store/apps/details?id=com.azure.authenticator",text:"Microsoft Authenticator (Android)"},{value:"https://apps.apple.com/us/app/salesforce-authenticator/id782057975",text:"Salesforce Authenticator (iOS)"},{value:"https://play.google.com/store/apps/details?id=com.salesforce.authenticator",text:"Salesforce Authenticator (Android)"});e.length===1&&(f.InstallApp=e[0].value,f.SelectedApp=f.InstallApp);i.verifyVia.email&&s.push({value:"email",text:t.VerifyVia.email});i.verifyVia.sms&&s.push({value:"sms",text:t.VerifyVia.sms});i.verifyVia.call&&s.push({value:"call",text:t.VerifyVia.call});i.verifyVia.app&&s.push({value:"app",text:t.VerifyVia.app});n.survey({context:i,text:t.Text,text2:n.touch.appName(),values:f,questions:[{name:"Consent",text:t.Consent,required:i.status!=="ready",items:{style:"CheckBoxList",list:[{value:"Enable",text:t.Setup.Consent}]}},{name:"Methods",type:"text",text:t.Setup.Methods,required:!0,items:{style:"CheckBoxList",list:s},visibleWhen:r},{name:"AppConfig",required:!0,items:{style:"RadioButtonList",list:[{value:"ScanQrCode",text:t.Setup.AppConfigScanQrCode},{value:"EnterSetupKey",text:t.Setup.AppConfigEnterSetupKey},{value:"InstallApp",text:t.Setup.AppConfigInstallApp},]},visibleWhen:function(){return i.verifyVia.app&&r(this)&&o(this)}},{name:"Url",text:t.Setup.ScanQrCode,options:{input:{qrcode:{valueHidden:!0,tooltipHidden:!0,scrollIntoView:!f.Methods||!f.Methods.match(/app/),size:"192x192"}}},visibleWhen:function(){var n=this.fieldValue("AppConfig");return i.verifyVia.app&&r(this)&&o(this)&&n==="ScanQrCode"}},{name:"EnterSetupKey",text:t.Setup.EnterSetupKey,mode:"static",options:{textAction:"copy"},visibleWhen:function(){var n=this.fieldValue("AppConfig");return r(this)&&o(this)&&n==="EnterSetupKey"}},{name:"InstallApp",text:t.AuthenticatorApp,required:!0,items:{style:"RadioButtonList",list:e},columns:1,causesCalculate:!0,visibleWhen:function(){var n=this.fieldValue("AppConfig");return r(this)&&o(this)&&n==="InstallApp"&&e.length>1}},{name:"SelectedApp",text:t.Setup.ScanAppQrCode,options:{input:{qrcode:{valueHidden:!0,scrollIntoView:!0,size:"192x192"}}},visibleWhen:function(){var n=this.fieldValue("AppConfig"),t=this.fieldValue("InstallApp");return r(this)&&o(this)&&n==="InstallApp"&&t}},{name:"BackupCodes",text:t.Setup.BackupCodes.Text,mode:"static",htmlEncode:!1,footer:t.Setup.BackupCodes.Footer,options:{textAction:"copy"},visibleWhen:function(){return r(this)&&this.fieldValue("Methods")&&this.fieldValue("Status")==="ready"&&this.fieldValue("BackupCodes")}},{name:"BackupCodeActions",text:!1,rows:1,items:{style:"Actions"},options:{mergeWithPrevious:!0},visibleWhen:function(){return r(this)&&this.fieldValue("Methods")&&this.fieldValue("Status")==="ready"&&this.fieldValue("BackupCodes")}},{name:"BackupCodesUnavailable",text:t.Setup.BackupCodes.Text,rows:1,items:{style:"Actions"},footer:t.Setup.BackupCodes.Footer,visibleWhen:function(){return r(this)&&this.fieldValue("Methods")&&this.fieldValue("Status")==="ready"&&!this.fieldValue("BackupCodes")}},{name:"Status",hidden:!0}],options:{modal:{fitContent:!0,autoGrow:!0,max:"sm"},materialIcon:"dialpad",discardChangesPrompt:!1},actions:[{text:u.Mobile.Next,execute:"otpauthtotpsetup_next.app",scope:"form",icon:"material-icon-arrow_forward",when:function(){return this.fieldValue("Status")!="ready"&&(!o(this)||this.fieldValue("AppConfig")!=="InstallApp")}},{text:i.status==="ready"?u.ModalPopup.SaveButton:u.Mobile.Enable,execute:"otpauthtotpsetup_save.app",scope:"form",icon:"material-icon-check",when:function(){return this.fieldValue("Status")==="ready"}},{text:u.ModalPopup.SaveButton,execute:"otpauthtotpsetup_backupcodessave.app",scope:"BackupCodeActions",causesValidation:!1},{text:u.Mobile.Generate,execute:"otpauthtotpsetup_backupcodesgenerate.app",scope:"BackupCodeActions",causesValidation:!1},{text:u.Mobile.Generate,execute:"otpauthtotpsetup_backupcodesgenerate.app",scope:"BackupCodesUnavailable",causesValidation:!1}],calculate:"otpauthtotpsetup_calculate.app"})},exec:function(u,f){function o(n,t){t!=null&&h.push(n+":"+(t==null?"null":t)+";")}var s;if(!i.busy()){var l=f.dataView||i.dataView(),e=l.data("survey"),h=[(e.password||"null")+";"];o("otpauth",e.otpauth);o("exec",u);for(s in f)o(s,f[s]);n.login(e.username,h.join(""),e.createPersistentCookie,function(n){i.busy(!0);e.callback?e.callback.success(n):n.event&&c.trigger($.Event(n.event,{args:n}))},function(){var u=i.dataView().data("survey").confirm,f=u==="verification_code"?t.Messages.InvalidVerificationCode:t.Messages.InvalidPassword;n.alert(f).then(function(){r.focus({field:u==="password"?"Password":"Passcode"})})})}}};c.on("otpauthtotp_submit.app",function(t){var f=t.dataView.data(),u=t.dataView.data("survey"),e=f.BackupCode,i=y(t.dataView);return i.error?n.alert(i.error).then(function(){r.focus({field:"Passcode"})}):(i=i.value,i==null&&(i=e),i=i.toString(),n.otpauth.totp.exec(t.dataView.data("survey").exec||"login",{passcode:i,trustThisDevice:f.TrustThisDevice,url:u.url,backupCodes:u.backupCodes,methods:u.methods})),!1}).on("otpauthtotp_getcode.app",function(f){var o;r.focus({field:"Passcode"});var e=f.dataView.data().Method.match(/^(\w+)\:(.+)$/),h=f.dataView.data("survey"),c,s=h.verify[e[1]];for(o=0;o<s.length;o++)s[o].value===e[2]&&(c=t.CodeSent[e[1]]+" "+s[o].text);return n.otpauth.totp.exec("send",{method:e[2],type:e[1],url:h.url,template:String.format(t.Messages.YourCode,i.appName()),confirmation:c}),setTimeout(function(){r.focus({field:"Passcode"})}),i.notify({text:u.Mobile.Wait,force:!0}),!1}).on("otpauthtotp_calculate.app",function(n){var i=n.rules._args.trigger,t=n.dataView,e=t.fieldValue("Passcode"),o=t.fieldValue("BackupCode"),u,f;return i==="Method"&&(u=t.fieldValue("Method"),u&&u.match(/^dial|app/)&&setTimeout(function(){r.focus({field:"Passcode"})})),i==="Passcode"&&(f=y(t),o!=null&&e!=null&&r.execute({BackupCode:null}),f.error||f.value==null||c.trigger($.Event("otpauthtotp_submit.app",{dataView:t,survey:t._survey}))),i==="BackupCode"&&o!=null&&e!=null&&r.execute({Passcode:null}),i==="TrustThisDevice"&&setTimeout(function(){r.focus({field:"Passcode"})}),!1}).on("beforefocus.input.app",'[data-field="Passcode"][data-type="pin"]',function(n){n.inputElement.data("change",d)}).on("beforefocus.keyboard.app",'[data-field="Passcode"][data-type="pin"]',function(n){n.context.change=d});c.on("otpauthtotpsetup_calculate.app",function(n){var i=n.rules._args.trigger,u=n.dataView,t;return i==="InstallApp"&&(t=u.fieldValue("InstallApp"),r.execute({SelectedApp:t})),!1}).on("otpauthtotpsetup_verificationcodesent.app",function(n){return i.notify({text:n.args.notify,force:!0}),!1}).on("otpauthtotpsetup_backupcodessave.app",function(){var t=i.dataView().data("survey").backupCodes,r=n.touch.appName()+" backup codes.txt";return n.saveFile(r,t.join("\r\n")),!1}).on("otpauthtotpsetup_backupcodesgenerate.app",function(t){var i=t.dataView.data("survey");return n.otpauth.totp.exec("generate",{url:i.url}),!1}).on("otpauthtotpsetup_backupcodesgeneratedone.app",function(n){var t=i.dataView().data("survey");return t.backupCodes=n.args.newBackupCodes,r.execute({BackupCodes:n.args.newBackupCodes.join(", ")}),setTimeout(function(){r.focus({field:"BackupCodeActions"})}),!1}).on("otpauthtotpsetup_next.app",function(n){return r.execute({Status:"ready"}),setTimeout(function(){r.focus({field:n.dataView.fieldValue("BackupCodes")?"BackupCodeActions":"BackupCodesUnavailable"})}),!1}).on("otpauthtotpsetup_save.app",function(i){function u(){n.otpauth.totp.exec("setup",{consent:r.Consent,url:f.url,backupCodes:r.BackupCodes,methods:r.Methods})}var r=i.dataView.data(),f=i.dataView.data("survey");return r.Consent?u():n.confirm(t.Messages.DisableQuestion).then(u),!1}).on("otpauthtotpsetup_confirm.app",function(i){return i.args.confirm==="verification_code"?n.otpauth.totp.login(i.args.options):i.args.confirm==="password"&&n.survey({context:i.args.options,text:t.Text,text2:n.touch.appName(),questions:[{name:"Password",mode:"password",text:t.EnterPassword,required:!0}],options:{modal:{fitContent:!0,max:"xs"},materialIcon:"password",discardChangesPrompt:!1},submitText:u.Mobile.Next,submit:"otpauthtotppassword_submit.app"}),!1}).on("otpauthtotppassword_submit.app",function(t){return n.otpauth.totp.exec(t.dataView.data("survey").exec,{password:t.dataView.fieldValue("Password")}),!1}).on("otpauthtotpsetup.app",function(t){var r=i.dataView().data("survey");return t.args.verifyVia=r.verifyVia,t.args.setup=r.setup||{},i.goBack(function(){n.otpauth.totp.setup(t.args)}),!1}).on("otpauthtotpsetup_complete.app",function(r){var u=r.args.setupType;return i.goBack(function(){u==="none"?n.alert(t.Messages.Disabled):i.goBack(function(){n.alert(u==="new"?t.Messages.Enabled:t.Messages.Changed)})}),!1}).on("oauth2consent.app",function(){l()&&w()?(a(),p("allow")):h?b():$app.restful({url:"/oauth2/v2"}).then(function(n){var r,i,t;h=n.scopes;for(r in f.Scopes)i=h[r],t=f.Scopes[r],t&&t.startsWith(f.WantsTo)&&(t=t.slice(f.WantsTo.length).trim(),t=t.charAt(0).toUpperCase()+t.slice(1)),i==null&&(h[r]=i={}),t&&(i.hint=t),i.icon||(i.icon=(nt[r]||{}).icon);b()})}).on("oauth2consent_allow.app",function(n){a();n.survey.context.allow=!0})})();