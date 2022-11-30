/*!
* Data Aquarium Framework  - Universal Input / Draw
* Copyright 2021 Code On Time LLC; Licensed MIT; http://codeontime.com/license
*/
(function(){function it(n){var t=n.parent().find(".app-toolbox-screen");return t.length||(t=o("app-toolbox-screen").insertBefore(n)),t}function r(n){var e=u(".app-toolbox-form"),s=e.is(".app-toolbox-visible"),h,o,c;switch(n){case"hide":e.removeClass("app-toolbox-visible");s&&setTimeout(function(){e.css("margin","")},100);it(e).hide();return;case"init":h=e.closest(".ui-page").find(".app-bar-buttons");it(e).show();e.css({left:t(h.find(".app-tool-"+i()._active)).left,marginBottom:t(h).height});o=f.screen();c=t(e);o.width<=f.toWidth("sm")?e.removeClass("app-toolbox-panel").css("left",""):(e.addClass("app-toolbox-panel"),c.right>o.left+o.width-9&&e.css("left",o.left+o.width-9-c.width));break;case"show":r("init").addClass("app-toolbox-visible");return;case"toggle":return r(s?"hide":"show");case"visible":return s}return e}function st(n,t,i){return(16777216+(n<<16)+(t<<8)+i).toString(16).slice(1)}function rt(t,u){var f="highlighter",y,l,p;if(t.is(".app-tool-pen")?f="pen":t.is(".app-tool-eraser")?f="eraser":t.is(".app-tool-blur")&&(f="blur"),f.match(/pen|highlighter|blur/)&&n.userVar("blobdrawtoolbox_active",f),i()._active=f,u){if(f!=="eraser"&&f!=="blur"){if(!r("visible")){r("init");var e=i()[f],a=e.settings.colors,s=e.settings.minWidth,v=e.config.width||s,c=o("app-toolbox-blobdraw").appendTo(r().empty()).css("minWidth","");a?(y=o("app-color-palette").appendTo(c),a.forEach(function(n){var t=b("app-color").css("background-color","#"+n).appendTo(y);n===e.config.color&&t.addClass("app-selected")})):c.css("minWidth",200);v&&s&&(l=n.input.slider("create",{value:v,min:s,max:e.settings.maxWidth,event:"blobdrawtoolboxwidth.app",container:o("app-width").appendTo(c)}),p=h(l.width(),e.settings.maxWidth*2).addClass("app-width-sample").css("margin",".5em 0").insertBefore(l),k(p))}r("toggle")}}else r("hide")}function k(n){var v=i()._active,a=i()[v],r=c(n),s=t(n),f=Math.round(s.width/6),e=Math.round(s.height/2),u=[{x:0,y:e},{x:f,y:0},{x:f*2,y:e},{x:f*3,y:e*2},{x:f*4,y:e},{x:f*5,y:0},{x:f*6,y:e}],o=0,h,l;for(r.fillStyle="transparent",r.clearRect(0,0,s.width,s.height),r.strokeStyle=et(a.config.color),r.lineWidth=a.config.width,r.lineCap="round",r.lineJoin="round";o<u.length-2;)h=o+1,l=h+1,r.beginPath(),r.moveTo(u[o].x,u[o].y),r.quadraticCurveTo(u[h].x,u[h].y,u[l].x,u[l].y,.33),r.stroke(),o=l}function i(){var i,t;if(!y){g.trigger($.Event("blobdrawtoolbox.app",{toolbox:l}));y={_active:n.userVar("blobdrawtoolbox_active")||l._default};for(i in l)t=l[i],typeof t=="object"&&(y[i]={opacity:t.opacity,fill:t.fill,blur:t.blur,config:n.userVar("blobdrawtoolbox_"+i)||t.config,settings:t.settings})}return y}function p(){return u(".app-canvas canvas")}function s(){var s=u(),n=p(),f=n.filter(".app-layer-top"),t=s.find(".app-tools"),v=t.find(".app-tool-pen"),y=t.find(".app-tool-highlighter"),h=t.find(".app-tool-eraser"),c=t.find(".app-tool-undo"),a=t.find(".app-tool-redo"),e,o,r;t.find(".app-selected").length||(r=i()._active,r==="eraser"&&(r=i()._active=l._default),t.find(".app-tool-"+r).addClass("app-selected"),["pen","highlighter","blur"].forEach(function(n){t.find(".app-tool-"+n).find(".app-indicator").css("background-color","#"+i()[n].config.color)}));o=n.filter(":visible").length>2;n=n.filter(".app-layer-commit");n=n.add(n.nextAll("canvas:visible,.app-layer-eraser"));e=n.length>2&&(!f.length||!f.is(".app-layer-commit"));h.toggleClass("app-disabled",!o);c.toggleClass("app-disabled",!e);a.toggleClass("app-disabled",!f.length)}function ht(){var r=p(),n=r.filter(".app-layer-top"),t,i,u=[];n.length?n.removeClass("app-layer-top"):n=r.last().prev();t=n;n=n.hide().prev().addClass("app-layer-top");i=t.data("restore");i&&(i.forEach(function(n){var t=n.data("undo");n.insertBefore(t).show();t.is(".app-layer-top")&&(t.removeClass("app-layer-top"),n.addClass("app-layer-top"));n.data("redo",t.detach());u.push(n)}),t.data("restore",u));s()}function ct(){var r=p(),n=r.filter(".app-layer-top"),t,i;n=n.removeClass("app-layer-top").next().show();t=n;i=t.data("restore");n.next().is('[data-draggable="blobimagecanvas"]')||n.addClass("app-layer-top");i?(i.forEach(function(n){var t=n.data("redo");t.insertBefore(n);n.fadeOut("fast",function(){$(this).detach()})}),t.fadeOut("fast",s)):s()}function lt(i,r){var p=i.closest(".app-canvas"),b=p.css("transform"),v,y,l;p.css("transform","none");var k=t(i.addClass("app-layer-eraser").show()),u=i.prev(),a,e,f,w=[],o=r._points;for(i.data("restore",w).hide();u.length&&u.prev().length;){if(u.is(":visible")&&(a=t(u),n.intersect(k,a))){for(e=h(a.width,a.height),v=parseFloat(u.css("left")),y=parseFloat(u.css("top")),e.css({left:v,top:y,opacity:u.css("opacity")}),f=c(e),f.drawImage(u[0],0,0),f.globalCompositeOperation="destination-out",f.lineCap="round",f.lineJoin="round",f.lineWidth=r._ctx.lineWidth,f.strokeStyle="red",f.beginPath(),f.moveTo(o[0].x-v,o[0].y-y),l=1;l<o.length;l++)f.lineTo(o[l].x-v,o[l].y-y);f.stroke();f.globalCompositeOperation="source-over";e.insertBefore(u);u.is(".app-layer-commit")&&e.addClass("app-layer-commit");w.push(u.data("undo",e).hide().detach());u=e}u=u.prev()}w.length||i.remove();p.css("transform",b);s()}function h(n,t,i){var r=tt("canvas","",i),u=1;return n=Math.floor(n),t=Math.floor(t),r[0].width=n*u,r[0].height=t*u,r.css({width:n,height:t}),r}function c(n){var t=t=n[0].getContext("2d"),i=1;return n.data("scaled")||(n.data("scaled",!0),t.scale(i,i)),t}function ut(n,t){return Math.floor(Math.random()*(t-n+1))+n}function ft(){var r=u(".app-bar-buttons"),n=r.find(".app-tools"),e=n.find(".app-tool").last(),i=r.find("[data-action-path]").first(),o=n.is(".app-fullwidth");n.removeClass("app-fullwidth").css("text-align","");i.length&&t(i).left-t(e).right<32&&(n.css("text-align","left"),t(i).left-t(e).right<32&&n.addClass("app-fullwidth"));n.is(".app-fullwidth")!==o&&f.pageResized()}function d(){var n=u(".app-drawing"),e,o,s,f,h,c,i=1,l=16;n.data("layers")&&(r("hide"),ft(),o=n.find(".app-canvas"),o.length&&(s=n.data("width"),f=n.data("height"),e=t(n),h=e.width-l*2,c=e.height-l*2,s>h&&(i=h/s,f*=i),f>c&&(i*=c/f),o.css("transform",i===1?"":"scale("+i+")"),n.data("scale",i)))}function et(n){return n.length===6&&(n="#"+n),n}function at(n,t){return{x:n.x+(t.x-n.x)/2,y:n.y+(t.y-n.y)/2}}var n=$app,w=n.input,f=n.touch,g=$(document),a=Web.DataViewResources,vt=a.Data,ot=a.ModalPopup,v=a.Draw,nt=a.Editor,t=n.clientRect,l={_default:"pen",pen:{config:{color:"e61b1b",width:3},settings:{colors:["000000","ffffff","d1d3d4","a7a9ac","808285","58595b","b31564","e61b1b","ff5500","ffaa00","ffce00","ffe600","a2e61b","26e600","008055","00aacc","004de6","3d00b8","6600cc","600080","f7d7c4","bb9167","8e562e","613d30","ff80ff","ffc680","ffff80","80ff9e","80d6ff","bcb3ff",],minWidth:1,maxWidth:24},opacity:1},highlighter:{config:{color:"ffe600",width:12},settings:{colors:["ffe600","26e600","44c8f5","ec008c","ff5500","6600cc"],minWidth:12,maxWidth:64},opacity:.7},blur:{config:{color:"000000",width:6},settings:{},opacity:1},eraser:{fill:!0,config:{color:"333333",width:20,density:25},settings:{}}},y,u=f.activePage,e=n.html,yt=e.tag,pt=e.div,wt=e.span,tt=e.$tag,bt=e.$p,o=e.$div,b=e.$span,kt=e.$a,dt=e.$i,gt=e.$li,ni=e.$ul;w.methods.blob._draw=function(i){var e=w.elementToField(i),g=e._dataView._pendingUploads,r=u('[data-field="'+e.Name+'"] .app-drop-box img'),p,a,k,y,l;if(!r.length){f.busy(!0);i.removeClass("app-empty").find(".app-drop-text").remove();k=i.closest("[data-field]").find("img");r=tt("img","",'draggable="false"').insertBefore(i.children().first());r.one("load",function(){f.busy(!1);w.methods.blob._draw(i)});r.attr("src",k.parent().data("href"));k.parent().remove();return}p=r[0].naturalWidth;a=r[0].naturalHeight;g&&g.forEach(function(n){n.fieldName===e.Name&&(y=n.layers)});f.whenPageShown(function(){function e(n,t,i){var u={pen:v.Pen,highlighter:v.Highlighter,blur:v.Blur,eraser:v.Eraser,undo:nt.Undo,redo:nt.Redo},r=b("ui-btn app-tool app-tool-"+n,'data-tooltip-location="above"').appendTo(g).attr("data-title",u[n]);f.icon("material-icon-"+t,r);i&&b("app-indicator").appendTo(r)}var k=f.scrollable(),tt,it,n=p,i=a,l,rt,w,ut=u(".app-drawing"),et=u(".app-bar-buttons").css("text-align","right"),ot=et.children().first(),g=o("app-tools");ot.length?g.insertBefore(ot):g.appendTo(et);o("app-toolbox-form app-toolbox-panel").insertAfter(k);e("pen","edit",!0);e("highlighter","brush",!0);e("blur","blur_on");e("eraser","edit_off");e("undo","undo");e("redo","redo");ft();tt=k.find(".app-page-header");it=t(tt);ut.appendTo(k).css({top:it.height});w=u(".app-canvas").css({width:n,height:i,"margin-left":-n/2,"margin-top":-i/2});y?(y.each(function(){$(this).appendTo(w).removeClass("app-layer-top")}),y.each(function(){var n=$(this),t=n.data("undo");t&&n.show().removeData("undo")})):(l=h(n,i).addClass("app-layer-commit"),l.appendTo(w),rt=c(l),rt.drawImage(r[0],0,0,p,a,0,0,n,i),l=h(n,i,'data-draggable="blobimagecanvas"'),l.css({cursor:"pointer"}).appendTo(w));ut.data({layers:[],width:n,height:i});d();s()});l=[e.HeaderText,u(".app-page-header h1").first().text()];l[0]==="&nbsp;"&&l.splice(0,1);n.survey({context:{field:e,image:r},text:l[0],text2:l[1],questions:[{name:"changed",type:"bool"}],options:{modal:{always:!0,buttons:{fullscreen:!1},fullscreen:!0,gap:!1,background:"transparent",title:{minimal:f.screen().height-a<175}},materialIcon:n.agent.ie?"tune":"draw",contentStub:!1},layout:'<div class="app-drawing"><div class="app-canvas"><\/div><\/div>',submitText:ot.SaveButton,submit:"drawblobsubmit.app"})};g.on("resized.app",d).on("pagereadycomplete.app",d).on("drawblobsubmit.app",function(i){var b=i.survey.context,f=b.field,l=f._dataView._pendingUploads,a=u(".app-drawing .app-canvas"),e=p(),o,v,y,w,r,s,k=a.css("transform");i.dataView.tag("discard-changes-prompt-none");e.length>2&&(a.css("transform","none"),e.each(function(n){var i=$(this).removeClass("app-layer-commit app-layer-top"),r=t(i),u=i.css("opacity");i.is(":visible")?(o||(o=h(r.width,r.height),v=c(o),y=r),n<e.length-1?(v.globalAlpha=u,v.drawImage(i[0],r.left-y.left,r.top-y.top)):i.prev().addClass("app-layer-commit")):i.remove()}),a.css("transform",k),l||(l=f._dataView._pendingUploads=[{fieldName:f.Name,files:[{name:"edit.png"}]}]),l.forEach(function(n){n.fieldName===f.Name&&(s=n)}),originalBlob=s.files[0],w=o[0].toDataURL(originalBlob.type,originalBlob.quality),b.image.attr("src",w),r=n.dataUrlToBlob(w),r.name=originalBlob.name,r.lastModified=originalBlob.lastModified,r.lastModifiedDate=originalBlob.lastModifiedDate,r.quality=originalBlob.quality,s.files=[r],s.layers=e.filter(":visible"))}).on("vclick",".app-tools .app-tool",function(){var n=$(this);return r("visible")?r("hide"):n.is(".app-disabled")||(n.is(".app-tool-pen,.app-tool-highlighter,.app-tool-blur,.app-tool-eraser")?n.is(".app-selected")?rt(n,!0):(n.parent().find(".app-selected").removeClass("app-selected"),n.addClass("app-selected"),rt(n)):(r("hide"),n.is(".app-tool-undo")?ht():n.is(".app-tool-redo")&&ct())),!1}).on("vclick",".app-toolbox-form .app-color-palette .app-color",function(){var r=$(this);r.parent().find(".app-color").removeClass("app-selected");r.addClass("app-selected");var f=i()._active,t=r.css("background-color").match(/(\d+)\,\s*(\d+),\s*(\d+)/),e=i()[f];return t=st(parseInt(t[1]),parseInt(t[2]),parseInt(t[3])),e.config.color=t,n.userVar("blobdrawtoolbox_"+f,e.config),u(".app-tool-"+f+" .app-indicator").css("background-color","#"+t),k(r.closest(".app-toolbox-form").find(".app-width-sample")),!1}).on("touchstart mousedown pointerdown",".app-toolbox-screen",function(){return r("hide"),!1}).on("blobdrawtoolboxwidth.app",function(t){var u=i()._active,r=i()[u];t.value!==r.config.width&&(r.config.width=t.value,n.userVar("blobdrawtoolbox_"+u,r.config),k(t.slider.parent().find(".app-width-sample")))});n.dragMan.blobimagecanvas={options:{taphold:!1,immediate:!0},start:function(n){var u=this,h=n.target,s,y,o,e,l;h.is(".app-drawing")&&(n.target=h=h.find(".app-canvas canvas").last());s=h;y=t(s);n.dir="all";u._scale=s.closest(".app-drawing").data("scale");u._time=(new Date).getTime();u._crect=y;o=u._addPoint(n);u._xOffset=0;u._yOffset=0;u._rect={left:o.x,top:o.y,right:o.x,bottom:o.y};u._points=[o,o];u._lastCompressedAt=0;e=u._ctx=c(s);e.lineCap="round";e.lineJoin="round";var p=u._tool=i()._active,a=i()[p],v=a.config,w=et(v.color);a.fill?e.fillStyle=w:e.strokeStyle=w;p==="blur"?(l=f.dataView().survey().context.image,e.strokeStyle=e.createPattern(l[0],"no-repeat"),u._blur=Math.round(Math.max(l[0].naturalHeight,l[0].naturalWidth)/128)):u._blur=null;e.lineWidth=v.width;e.filter=u._blur?"blur("+u._blur+"px)":"none";u._lineDensity=v.density;s.css("opacity",a.opacity);u._drawLine(0);u._points.splice(1,1);r("hide")},move:function(n){var t=this,o=(new Date).getTime(),r=t._rect,f=t._points,e=t._lastCompressedAt,s=e,u=t._ctx,h=u.lineWidth,i=t._addPoint(n),c=Math.max(2,Math.ceil(window.devicePixelRatio/t._scale));i.x<r.left&&(r.left=i.x);i.y<r.top&&(r.top=i.y);i.x>r.right&&(r.right=i.x);i.y>r.bottom&&(r.bottom=i.y);f.push(i);t._tool==="eraser"||u.filter!=="none"?t._drawLine(0):t._drawCurve()},cancel:function(n){this.end(n)},end:function(i){var a=this,v=i.target,p=v.closest(".app-canvas"),nt=p.css("transform"),o,u,g;p.css("transform","none");var e=t(v),w=t(v.parent()),r=a._rect,l,b=a._ctx,tt=a._blur||0,f=b.lineWidth+tt,k,p=v.closest(".app-canvas"),y=p.find(".app-layer-top"),d=[];if(y.length){for(y=y.removeClass("app-layer-top").next();!y.is('[data-draggable="blobimagecanvas"]');)d.push(y),y=y.next();d.forEach(function(n){n.remove()})}r.width=r.right-r.left+1+f*2;r.height=r.bottom-r.top+1+f*2;r.left-=f;r.top-=f;r.right+=f;r.bottom+=f;a._xOffset=r.left;a._yOffset=r.top;g={left:r.left+e.left+f/2,top:r.top+e.top+f/2,right:r.right+e.left-f/2,bottom:r.bottom+e.top-f/2};n.intersect(g,e)&&(n.input.execute({changed:!0}),l=h(r.width,r.height),l.css("opacity",v.css("opacity")),k=c(l),o={left:0,top:0,width:r.width,height:r.height},u={left:r.left,top:r.top,width:r.width,height:r.height,right:r.left+r.width-1,bottom:r.top+r.height-1},u.left<0&&(o.left=-u.left,o.width+=u.left,u.width+=u.left,u.left=0),u.top<0&&(o.top=-u.top,o.height+=u.top,u.height+=u.top,u.top=0),u.right>e.width&&(u.width-=u.right-e.width+1,o.width-=u.right-e.width+1),u.bottom>e.height&&(u.height-=u.bottom-e.height+1,o.height-=u.bottom-e.height+1),k.drawImage(v[0],u.left,u.top,u.width,u.height,o.left,o.top,o.width,o.height),l[0].style.left=Math.round(e.left-w.left+r.left)+"px",l[0].style.top=Math.round(e.top-w.top+r.top)+"px",l.insertBefore(v),b.clearRect(r.left-f,r.top-f,r.width+f,r.height+f),a._tool==="eraser"?l.fadeOut("fast",function(){lt(l,a)}):s());p.css("transform",nt)},_addPoint:function(n){var r=this,t=r._scale,u=r._crect,i={x:Math.round(n.x-u.left),y:Math.round(n.y-u.top)};return t!==1&&(i.x*=1/t,i.y*=1/t),i},_drawCurve:function(){var o=this,n=o._ctx,t=o._rect,u=n.lineWidth,r=o._points,i=r[0],f=r[1],s,e=1;for(n.clearRect(t.left-u,t.top-u,t.right-t.left+1+u*2,t.bottom-t.top+1+u*2),n.beginPath(),n.moveTo(i.x,i.y);e<r.length-1;)s=at(i,f),n.quadraticCurveTo(i.x,i.y,s.x,s.y),i=r[e],f=r[e+1],e++;n.lineTo(f.x,f.y);n.stroke()},_drawLine:function(n){var t=this,r=t._ctx,i=t._points,u=i.length-1-n,o=u-1,h=t._xOffset,e=t._yOffset,f,s,c,l;if(t._tool==="eraser")for(f=t._ctx.lineWidth/2,s=0;s<t._lineDensity;s++)c=ut(-f,f),l=ut(-f,f),r.fillRect(i[u].x-e+c,i[u].y-e+l,1,1);else o>=0&&(r.beginPath(),r.moveTo(i[o].x-h,i[o].y-e),r.lineTo(i[u].x-h,i[u].y-e),r.stroke())}}})();