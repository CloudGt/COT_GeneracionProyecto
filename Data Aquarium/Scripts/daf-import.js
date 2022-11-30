/*!
* Data Aquarium Framework - Import 
* Copyright 2021 Code On Time LLC; Licensed MIT; http://codeontime.com/license
*/
(function(){function u(){var n=arguments;if(n.length)i.busy(n[0]);else return i.busy()}function f(){return(new Date).getTime()}function a(n){return n.match(/\.(\w+)$/)[1].toLowerCase()}var n=$app,i=n.touch,s=i.settings("import.batchSize")||10,e=Web.DataViewResources,v=e.Data,r=e.Mobile,t=r.Import,h=e.Actions,c=v.NoRecords,y=e.Validator.Required,o=i.whenPageShown,p=i.whenPageCanceled,l=n.findDataView;n.import=function(e,v){function b(t){var f=n.import.state.queues.errors,e=v.data[t.index-1],u,i;if(!f.length){i=[r.Line,r.Error];for(u in e)i.push(u);f.push(n.csv.toString(i))}i=[t.index+1,t.error];for(u in e)i.push(e[u]);f.push(n.csv.toString(i))}function d(n,t){for(var i,u=v.data,f=t.DataFormatString,r=0;r<Math.min(u.length,100);r++)if(i=u[r],i&&(i=i[n]),i)break;return i&&t.Type.match(/^Date/)&&typeof i=="number"&&(i=f?String.format(f,rt(i)):i.toString()),i}function et(n){for(var r="",t=0,i=10240;t<n.byteLength/i;++t)r+=String.fromCharCode.apply(null,new Uint8Array(n.slice(t*i,t*i+i)));return r+String.fromCharCode.apply(null,new Uint8Array(n.slice(t*i)))}function g(n){var t=n[n.length-1];return t=="Z"?n.length-1>0?g(n.substring(0,n.length-1))+"A":"AA":n.substring(0,n.length-1)+String.fromCharCode(n.charCodeAt(n.length-1)+1)}function nt(n){this.message=n}function ot(){var i=v.dataView,u=v.view;n.survey({text:i.get_view().Label,text2:h.Scopes.ActionBar.Import.HeaderText,parent:i._id,context:{id:i._id,controller:i._controller,view:u},controller:"import_from_file",topics:[{description:t.SelectFile,wrap:!0,questions:[{name:"file",text:!1,type:"blob"}]}],options:{materialIcon:"publish",discardChangesPrompt:!1,modal:{fitContent:!0,max:"xs",always:!0}},submitText:r.Submit,submit:function(i){function e(){isTouchPointer||inputFocus({fieldName:"file"})}var f=i.dataView,u=f.data(),s=f.survey().context;u.file?n.import("supports",{name:u.file[0].name})?o(function(){n.import("parse",{file:u.file[0],callback:function(t){n.import("map",{data:t,name:u.file[0].name,context:s})}})}):(i.preventDefault(),n.alert(String.format(t.NotSupported,u.file[0].name),e)):(i.preventDefault(),n.alert(r.Files[isTouchPointer?"Tap":"Drop"],e))}})}function tt(){var s,i,l;try{if(s=w.result,a(v.file.name)==="csv")i=$.csv.toObjects(s);else{i=[];var tt=et(s),y=XLSX.read(btoa(tt),{type:"base64"}),h=y.Sheets[y.SheetNames[0]],p=h["!ref"],r=p?p.match(/(([A-Z]+)(\d+))\:(([A-Z]+)(\d+))/):null,b,k,t,f,e,o=[],d=[];if(!r)throw new nt(c);if(b=r[2],k=r[5],f=parseInt(r[3]),lastRow=parseInt(r[6]),f<lastRow){for(e=f+1,t=b;t!=k;)o.push(t),t=g(t);for(o.push(t),o.forEach(function(n){var t=h[n+f];d.push(t?t.v:null)});e<=lastRow;)l={},i.push(l),o.forEach(function(n,t){var i=h[n+e],r=d[t];r&&(l[r]=i?i.v:null)}),e++}}if(i.length)u(!1),v.callback&&v.callback(i);else throw new nt(c);}catch(it){u(!1);n.alert(it.message)}}function it(r){function ut(n,t){var i=rt[n.Name];i.value=t;i.items.list.push({value:t,text:t});u.splice(u.indexOf(t),1)}function et(n,t){return n.toLowerCase().indexOf(t.toLowerCase())!==-1}var f=v.context,y,w,e;if(!arguments.length){n.execute({controller:f.controller,view:f.view||"createForm1",requiresData:!1,success:function(n){it(n)}});return}var c=l(f.id),g=(c._filterFields||"").split(","),nt=r.fields,a=[],u=[],b,s=[],tt=c.get_view().Label,k=[],rt={};for(b in v.data[0])a.push(b.toLowerCase()),u.push(b);if(f.importColumns=u.slice(0),nt.forEach(function(n){var o=n;if(n=nt[n.AliasIndex],!o.Hidden&&!n.OnDemand&&!o.ReadOnly&&o.Type!=="DataView"){var r=n.Name,l=n.HeaderText,i={name:r,text:l,causesCalculate:!0,items:{style:"DropDownList",list:[{value:null,text:t.NotMatched}]},value:null,columns:30,placeholder:t.NotMatched,required:!n.AllowNulls&&!n.HasDefaultValue},e=a.indexOf(l.toLowerCase()),v=g.indexOf(o.Name);if(v!==-1){if(v>0)return;delete i.items;var p=c.context(),h=p.headerField(),y=c.context("data");i.value=h?h.format(y[h.Name]):nullValueInForms;i.readOnly=!0;f.masterKey=[];g.forEach(function(n){f.masterKey.push({field:n,newValue:y[o.ItemsDataValueField||n],modified:!0})})}else e===-1&&(e=a.indexOf(r.toLowerCase())),e===-1?s.push(n):(r=u[e],i.value=r,i.items.list.push({value:r,text:r}),a.splice(e,1),u.splice(e,1));k.push(i);rt[i.name]=i}}),s.length){for(y=0;y<u.length;)e=u[y],w=null,$(s).each(function(n){var t=this;if(et(t.HeaderText,e)||et(t.Name,e))return w=t,s.splice(n,1),!1}),w?ut(w,e):y++;s.length&&s.forEach(function(n){e=null;$(u).each(function(){var t=this;if(t.indexOf(n.HeaderText)!==-1||t.indexOf(n.Name)!==-1)return e=t.toString(),!1});e&&ut(n,e)})}k.forEach(function(n){u.forEach(function(t){n.items&&n.items.list.push({value:t,text:t})});var t=n.value,i;t&&(i=r.map[n.name],n.footer=d(t,i))});f.availableColumns=u;f.metadata=r;n.survey({controller:"import_map",text:tt,text2:h.Scopes.ActionBar.Import.HeaderText,description:String.format(t.FileStats,v.data.length,v.name),questions:k,options:{modal:{max:"xs",fitContent:!0,always:!0},materialIcon:"settings_input_component"},context:f,submit:function(r){var u=r.dataView,f,e;v.fieldMap=u.data();for(f in v.fieldMap)e=u.findField(f),(!e||e.ReadOnly)&&delete v.fieldMap[f];u.discard();o(function(){o(function(){var n=i.pageInfo();p(function(){n._canceled||n.dataView.survey().cancel()});ft("init")});n.survey({controller:"import_status",options:{modal:{max:"xxs",fitContent:!0,always:!0,buttons:{more:!1,fullscreen:!1}},contentStub:!1},questions:[],layout:String.format('<div style="padding:1em"><div>{0} <b>{1}<\/b> {2} <b>{3}<\/b>...<\/div><div class="app-import-status">&nbsp;<br/>&nbsp;<br/>&nbsp;<br/>&nbsp;<\/div><\/div>',t.Importing,v.name,t.Into,tt),submit:!1,cancel:function(){n.import.state=null}})})},submitText:t.StartImport,calculate:function(t){var i=t.dataView,e=i._fields,o=i.survey(),s=o.context,u=s.importColumns.slice(0),f=i.data();e.forEach(function(t){if(!t.ReadOnly){var i=f[t.Name],e=t.FooterText;i!=null?(u.splice(u.indexOf(i),1),t.FooterText=d(i,r.map[t.Name])):t.FooterText=null;e!==t.FooterText&&setTimeout(n.input.execute,0,{values:{name:t.Name,value:f[t.Name]}})}});e.forEach(function(n){if(!n.ReadOnly){var t=n.Items,i=f[n.Name];n.ItemCache=null;t.splice(1);i!=null&&t.push([i,i]);u.forEach(function(n){t.push([n,n])})}})}})}function rt(n){var u=Math.floor(n-25569),f=u*86400,i=new Date(f*1e3),e=n-Math.floor(n)+1e-7,t=Math.floor(86400*e),r=t%60;t-=r;var o=Math.floor(t/3600),s=Math.floor(t/60)%60,h=String.format("{0:d4}-{1:d2}-{2:d2}T{3:d2}:{4:d2}:{5:d2}.000Z",i.getUTCFullYear(),i.getUTCMonth()+1,i.getUTCDate(),o,s,r);return Date.fromUTCString(h)}function ut(t){var i=n.import.state;i.busy=!1;i.mode="error";i.error=t.get_message()}function ft(){function ui(){var n,t;for(li.forEach(function(n){var i=e.lookup[n._ilc.lookupIndex],t=u.lookupCache[n._ilc.entryKey][n.filter[0].value];t.v!=null&&(i.values[n._ilc.valueIndex].newValue=t.v)}),n=bi;n<=ai;n++)t=e.lookup[n],t.error?b(t):e.submit.push(t)}var u=n.import.state,w,lt,et,vt,gt,ni,ti,a,d,ht,it,ii,vi,ri,yi;if(arguments[0]==="init"){n.import.state=u=v;var fi=u.context.metadata,pi=u.fields={},ei=u.fieldMap,et=u.columnMap={};for(w in ei)lt=ei[w],lt&&(et[lt]=w);u.duplicate={test:[],accept:[]};fi.fields.forEach(function(n){pi[n.Name]=n;var t=n.Tag;t&&(t.match(/\bimport-duplicate-test\b/)&&u.duplicate.test.push(fi.fields[n.AliasIndex]),t.match(/\bimport-duplicate-accept\b/)&&u.duplicate.accept.push(n.Name))});u.status=i.activePage(".app-import-status");u.dataView=l(u.context.id);u.index=0;u.count=0;u.lookupCache={};u.queues={lookup:[],nextLookup:0,test:[],submit:[],errors:[]};u.started=f();u.mode="scan"}else if(u){var e=u.queues,wi=f(),k=u.data,at=u.context.controller,oi=u.context.view;if(u.mode==="scan"){if(et=u.columnMap,k.length)while(u.index<k.length){vt=k[u.index++];var nt=[],w,h,tt,o,p,c=[],yt,ot=[],pt=[],si=u.duplicate.test;for(w in et)if(o=vt[w],h=u.fields[et[w]],h&&v.fieldMap[h.Name]===w)if(tt=h.Name,p=h.OriginalIndex!==h.Index?u.fields[u.context.metadata.fields[h.OriginalIndex].Name]:null,o==null)p&&(h=p),nt.push({field:h.Name,newValue:o,modified:!0}),si.indexOf(h)!==-1&&ot.push(tt+": "+y);else{if(p)if(tt=p.Name,o==="")o=null;else{var hi=p.ItemsDataController,ci=p.ItemsDataView,wt=p.ItemsDataTextField,bt=p.ItemsDataValueField,kt=hi+"_"+ci+"_"+bt+"_"+wt,st=u.lookupCache[kt],g,dt;st||(st=u.lookupCache[kt]={});g=st[o];g&&g.v!=null?o=g.v:bt&&(yt={controller:hi,view:ci,filter:[{field:wt,value:o}]},yt.fieldFilter=[bt,wt],dt={valueIndex:nt.length,args:yt,entryKey:kt},c.push(dt),g?dt.resolve=!0:g=st[o]={v:null},o=null)}else o===""?o=null:typeof o=="number"&&h.Type.match(/^Date/)?o=rt(o):typeof o=="string"&&o&&h.Type!=="String"&&(gt={NewValue:o},ni=u.dataView._validateFieldValueFormat(u.fields[tt],gt),ni?ot.push(h.HeaderText+": "+ni):(o=gt.NewValue,typeof o=="number"&&h.Type.match(/^Date/)&&(o=new Date(o))));nt.push({field:tt,newValue:o,modified:!0});si.indexOf(h)!==-1&&pt.push({field:h.Name,value:vt[w]})}if(ti=u.context.masterKey,a={index:u.index,type:"submit",command:"Insert",values:nt},ti&&ti.forEach(function(n){nt.push(n)}),ot.length?(a.error=ot.join("\n"),b(a)):pt.length?(c.length&&(a.requests=c),a.filter=pt,e.test.push(a)):c.length?(a.type="lookup",a.requests=c,e.lookup.push(a)):e.submit.push(a),f()-wi>8)break}u.mode="send"}else if(u.mode==="send"){if(!u.busy){if(e.submit.length)u.busy=!0,d=[],ht=0,$(e.submit).each(function(n){if(n>=s)return!1;for(var t=this,u=[],r,f,i=0;i<t.values.length;i++)r=t.values[i],r&&(u.push(r),r.newValue!=null&&(f=!0));f?d.push({command:t.command,controller:at,view:oi,values:u,_src:t}):ht++}),e.submit.splice(0,d.length+ht),u.count+=ht,d.length?(u.message=t.InsertingRecords,n.execute({batch:d,done:function(t){var i=n.import.state;i.busy=!1;i.count+=d.length;d.forEach(function(n,i){var r=t[i];r.errors.length&&(n._src.error=r.errors.join("\n"),b(n._src))})},fail:ut})):u.busy=!1;else if(e.test.length)u.busy=!0,u.message=t.TestingRecords,it=[],ii=u.duplicate.accept,$(e.test).each(function(n){if(n>=s)return!1;var t=this;it.push({controller:at,view:oi,filter:t.filter,requiresRowCount:!1,fieldFilter:["_pk_only"],_trc:t})}),e.test.splice(0,it.length),n.execute({batch:it,done:function(i){var r=n.import.state;r.busy=!1;i.forEach(function(n,i){var f=n[at],r=it[i]._trc,o,h,c,u,s,l;if(f.length){if(ii.length)if(f.length===1){if(r.command="Update",o=r.values,c=0,o.forEach(function(n,t){ii.indexOf(n.field)===-1?o[t]=null:c++}),c){u=r.requests;for(h in f[0])o.push({field:h,oldValue:f[0][h],modified:!1});if(u)for(s=0;s<u.length;)l=u[s],l.resolve=!1,o[l.valueIndex]?s++:u.splice(s,1);u&&u.length?e.lookup.push(r):e.submit.push(r)}}else r.error=t.Duplicates+": "+f.length,b(r)}else r.requests?(r.requests.forEach(function(n){n.resolve=!1}),e.lookup.push(r)):e.submit.push(r)})}});else if(e.nextLookup<e.lookup.length){u.busy=!0;c=[];for(var li=[],bi=e.nextLookup,ai,ct,ki=10;ki-->0;)if(ct=e.nextLookup++,e.lookup[ct].requests.forEach(function(n){n.args._ilc={lookupIndex:ct,valueIndex:n.valueIndex,entryKey:n.entryKey};n.resolve?li.push(n.args):c.push(n.args)}),ct===e.lookup.length-1)break;ai=e.nextLookup-1;u.message=t.ResolvingReferences;c.length?n.execute({batch:c,done:function(t){var i=n.import.state,u=i.queues;i.busy=!1;t.forEach(function(n,t){var f=c[t],e=n[f.controller],s=f._ilc.lookupIndex,o=u.lookup[s],h=i.lookupCache[f._ilc.entryKey][f.filter[0].value];e&&e.length?h.v=o.values[f._ilc.valueIndex].newValue=e[0][n.primaryKey[0].Name]:o.error=String.format('{0}: {1} = "{2}"',r.DidNotMatch,n.map[f.filter[0].field].Label,f.filter[0].value)});ui()},fail:ut}):(u.busy=!1,ui())}else e.test.length&&(u.mode="done");u.index<k.length?u.mode="scan":!e.submit.length&&e.nextLookup>=e.lookup.length&&!e.test.length&&!u.busy&&(u.mode="done")}}else u.mode==="error"&&(message=u.error);vi=f();ri=new Date(f()-u.started);u.status.html(String.format("{0:N1}% {1}<br/>{2}...<br/>{3}: {4}<br/>{5}: {6}",u.count/k.length*100,t.Complete,u.message||t.TestingRecords,t.Expected,ri<6e4?r.Dates.InAMin:i.toSmartDate(new Date(vi+Math.round(ri/(u.count||1)*(k.length-u.count)))),t.Remaining,k.length-u.count));u.mode==="done"&&(i.pageInfo()._canceled=!0,yi=u.dataView,i.goBack(function(){e.errors.length&&n.saveFile("errors_"+v.name+".csv",e.errors.join("\r\n"),"text/csv");setTimeout(function(){n.alert(String.format("{0} <b>{1}<\/b> {2} <b>{3}<\/b>.",t.Done,v.name,t.Into,yi.get_view().Label),function(){i.sync(v.context.id)})})}),u=null)}u&&u.mode!=="error"&&setTimeout(ft,32)}if(e==="upload")ot();else{if(e==="supports")return extension=v.name.match(/\.(\w+)$/),extension&&!!extension[1].match(/^(csv|xlsx|xls)/i);if(e==="parse"){u(!0);$(".app-glass-pane").addClass("app-glass-pane-reject");var w=new FileReader,k=v.file;a(k.name)==="csv"?w.readAsText(k):w.readAsArrayBuffer(k);w.onload=function(){try{$.csv?tt():$.getScript(__baseUrl+"js/lib/import.min.js",tt)}catch(t){u(!1);n.alert(t.message)}};w.onerror=function(t){u(!1);n.alert(t.message)}}else e==="map"&&it()}}})();