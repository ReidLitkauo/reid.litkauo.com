!function(n){var t={};function e(o){if(t[o])return t[o].exports;var r=t[o]={i:o,l:!1,exports:{}};return n[o].call(r.exports,r,r.exports,e),r.l=!0,r.exports}e.m=n,e.c=t,e.d=function(n,t,o){e.o(n,t)||Object.defineProperty(n,t,{enumerable:!0,get:o})},e.r=function(n){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(n,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(n,"__esModule",{value:!0})},e.t=function(n,t){if(1&t&&(n=e(n)),8&t)return n;if(4&t&&"object"==typeof n&&n&&n.__esModule)return n;var o=Object.create(null);if(e.r(o),Object.defineProperty(o,"default",{enumerable:!0,value:n}),2&t&&"string"!=typeof n)for(var r in n)e.d(o,r,function(t){return n[t]}.bind(null,r));return o},e.n=function(n){var t=n&&n.__esModule?function(){return n.default}:function(){return n};return e.d(t,"a",t),t},e.o=function(n,t){return Object.prototype.hasOwnProperty.call(n,t)},e.p="",e(e.s=10)}([function(n,t){$((function(){return $("header .nav-icon-wrap").on("click keypress",(function(n){return $("header").toggleClass("nav-open")})),$("header .nav-clickout").on("click keypress",(function(n){return $("header").removeClass("nav-open")})),$("header nav a").on("click keypress",(function(n){return $("header").removeClass("nav-open")}))}))},function(n,t){window.nn_bias2color=function(n,t=100){var e,o,r,a,c,i,s;if(null==window.nn_data)throw"nn_data not loaded";if(null==this.min||null==this.max)for(this.min=999999,this.max=-999999,o=0,a=(i=window.nn_data.biases).length;o<a;o++)for(r=0,c=(e=i[o]).length;r<c;r++)(s=e[r])>this.max&&(this.max=s),s<this.min&&(this.min=s);return n=(n-this.min)/(this.max-this.min),n=sigmoid(-8*(1-2*(n+.01))),"hsla("+(30+Math.round(300*n))+"deg, 80%, 50%, "+t+"%)"},window.nn_weight2color=function(n,t=100){var e,o,r,a,c,i,s,l,u,f;if(null==window.nn_data)throw"nn_data not loaded";if(null==this.min||null==this.max)for(this.min=999999,this.max=-999999,e=0,a=(l=window.nn_data.weights).length;e<a;e++)for(o=0,c=(f=l[e]).length;o<c;o++)for(r=0,i=(s=f[o]).length;r<i;r++)(u=s[r])<this.min&&(this.min=u),u>this.max&&(this.max=u);return n=(n-this.min)/(this.max-this.min),n=sigmoid(-8*(1-2*n)),"hsla("+(30+Math.round(300*n))+"deg, 80%, 50%, "+t+"%)"}},function(n,t){var e,o=[].indexOf;$.ajax("/assets/nn-params.json",{cache:!0,dataType:"json",success:function(n,t,o){return $((function(){return e(n)}))}}),$.ajax("/assets/nn-samples.json",{cache:!0,dataType:"json",success:function(n,t,e){return window.nn_samples=n,nn_loop()}}),e=function(n){var t,e,r,a,c,i,s,l,u,f,h,d,p,w,_,g;for(window.nn_data=n,0,50,"%",0,100/15,2,"%",window.nn_neuron_ctx=function(){var n,t;for(t=[],e=n=0;n<=2;e=++n)t.push($(".network .neurons.layer-"+e+" canvas.top")[0].getContext("2d"));return t}(),f=function(){var n,t;for(t=[],e=n=0;n<=2;e=++n)t.push($(".network .neurons.layer-"+e+" canvas.btm")[0].getContext("2d"));return t}(),i=r=0;r<=2;i=++r)for(u=a=0;a<=15;u=++a)2===i&&(o.call([0,1,2],u)>=0||o.call([13,14,15],u)>=0)||(h=2===i?u-3:u,90,w=90+200*u,90,70,f[i].beginPath(),f[i].fillStyle=nn_bias2color(n.biases[i][h]),f[i].arc(90,w,90,0,2*Math.PI),f[i].fill(),f[i].closePath(),f[i].beginPath(),f[i].fillStyle="hsl(0deg, 0%, 15%)",f[i].arc(90,w,70,0,2*Math.PI),f[i].fill(),f[i].closePath());for(window.nn_conn_ctx=function(){var n,t;for(t=[],e=n=0;n<=1;e=++n)t.push($(".network .connections.layer-"+e+" canvas.top")[0].getContext("2d"));return t}(),t=function(){var n,t;for(t=[],e=n=0;n<=1;e=++n)t.push($(".network .connections.layer-"+e+" canvas.btm")[0].getContext("2d"));return t}(),i=c=0;c<=1;i=++c)for(t[i].lineWidth=10,nn_conn_ctx[i].lineWidth=10,u=s=0;s<=15;u=++s)for(p=l=0;l<=15;p=++l)1===i&&(o.call([0,1,2],p)>=0||o.call([13,14,15],p)>=0)||(h=u,d=1===i?p-3:p,0,_=90+200*u,970,g=90+200*p,t[i].beginPath(),t[i].strokeStyle=nn_weight2color(n.weights[i+1][d][h],15),t[i].moveTo(0,_),t[i].lineTo(970,g),t[i].stroke(),t[i].closePath());return nn_loop(),!0}},function(n,t){window.nn_guess=(n,t,e)=>{var o,r,a,c,i,s,l,u;for(r=function(n){var t,e;for(t in e=0,n)n[t]>=n[e]&&(e=t);return parseInt(e)},u=function(n){return 1/(1+Math.exp(-n))},c=function(n,t,e){var o,r,a,c,i,s,l,f,h,d,p,w,_,g,m,y,v;for(a in m=[],n)if((_=n[a]).length!==e.length)throw"["+a+"] wcols != arows: "+_.length+" != "+e.length;if(t.length!==n.length)throw"brows != wrows: "+t.length+" != "+n.length;for(a in t)if(t[a].length!==e[0].length)throw"["+a+"] bcols != acols: "+t[a].length+" != "+e[0].length;for(g=n.length,p=n[0].length,e.length,o=e[0].length,w=c=0,f=g;0<=f?c<f:c>f;w=0<=f?++c:--c){for(v=[],r=i=0,h=o;0<=h?i<h:i>h;r=0<=h?++i:--i){for(y=0,l=s=0,d=p;0<=d?s<d:s>d;l=0<=d?++s:--s)y+=n[w][l]*e[l][r];y+=t[w][r],y=u(y),v[r]=y}m[w]=v}return m},o=[(a=function(n){var t,e,o,r,a;for(r=[],t=e=0,o=n[0].length;0<=o?e<o:e>o;t=0<=o?++e:--e)r.push(function(){var e,o,r;for(r=[],e=0,o=n.length;e<o;e++)a=n[e],r.push(a[t]);return r}());return r})([e])],s=i=0,l=t.length;0<=l?i<l:i>l;s=0<=l?++i:--i)o[s+1]=c(n[s],a([t[s]]),o[s]);return[r(a(o[o.length-1])[0]),o]}},function(n,t){var e=[].indexOf;window.nn_run=async function(n){var t,o,r,a,c,i,s,l,u,f,h,d,p,w,_,g,m,y,v,b,x;for(v=nn_guess(window.nn_data.weights,window.nn_data.biases,n),(r=$(".nn .io .input canvas")[0].getContext("2d")).clearRect(0,0,28,28),x=o=0;o<=28;x=++o)for(b=a=0;a<=28;b=++a)r.fillStyle="hsl(0deg, 0%, "+Math.round(100*n[28*x+b])+"%)",r.fillRect(20*b,20*x,20,20);for(s=c=0;c<=2;s=++c)for(nn_neuron_ctx[s].clearRect(0,0,180,3180),f=i=0;i<=15;f=++i)2===s&&(e.call([0,1,2],f)>=0||e.call([13,14,15],f)>=0)||(h=2===s?f-3:f,90,g=90+200*f,90,70,t="hsl(0deg, 0%, "+Math.round(100*v[1][s+1][h])+"%)",nn_neuron_ctx[s].beginPath(),nn_neuron_ctx[s].fillStyle=nn_bias2color(nn_data.biases[s][h]),nn_neuron_ctx[s].arc(90,g,90,0,2*Math.PI),nn_neuron_ctx[s].fill(),nn_neuron_ctx[s].closePath(),nn_neuron_ctx[s].beginPath(),nn_neuron_ctx[s].fillStyle=t,nn_neuron_ctx[s].arc(90,g,70,0,2*Math.PI),nn_neuron_ctx[s].fill(),nn_neuron_ctx[s].closePath());for(s=l=0;l<=1;s=++l)for(nn_conn_ctx[s].clearRect(0,0,970,3180),f=u=0;u<=15;f=++u)for(p=w=0;w<=15;p=++w)1===s&&(e.call([0,1,2],p)>=0||e.call([13,14,15],p)>=0)||(h=f,d=1===s?p-3:p,0,m=90+200*f,970,y=90+200*p,_=Math.round(80*v[1][s+1][h]),nn_conn_ctx[s].beginPath(),nn_conn_ctx[s].strokeStyle=nn_weight2color(nn_data.weights[s+1][d][h],_),nn_conn_ctx[s].moveTo(0,m),nn_conn_ctx[s].lineTo(970,y),nn_conn_ctx[s].stroke(),nn_conn_ctx[s].closePath());return $(".nn .io .input canvas").css("opacity",1),await sleep(400),$(".nn .network .neurons.layer-0 canvas.top").css("opacity",1),await sleep(400),$(".nn .network .connections.layer-0 canvas.btm").css("opacity",0),$(".nn .network .connections.layer-0 canvas.top").css("opacity",1),await sleep(500),$(".nn .network .neurons.layer-1 canvas.top").css("opacity",1),await sleep(400),$(".nn .network .connections.layer-1 canvas.btm").css("opacity",0),$(".nn .network .connections.layer-1 canvas.top").css("opacity",1),await sleep(400),$(".nn .network .neurons.layer-2 canvas.top").css("opacity",1),await sleep(400),sevenseg($(".nn .io .output .sevenseg"),v[0]),!0}},function(n,t){window.nn_clear=function(){return $(".nn .network canvas.btm").css("opacity",1),$(".nn .network canvas.top").css("opacity",0),$(".nn .io .input canvas").css("opacity",0),sevenseg($(".nn .io .output .sevenseg")),!0}},function(n,t){window.nn_loop=async function(){if(null==window.nn_data||null==window.nn_samples)return!1;for(null==this.break&&(this.break=!1),null==this.i&&(this.i=0);!this.break;)nn_clear(),await sleep(1500),await nn_run(nn_samples[this.i++%window.nn_samples.length]),await sleep(3e3);return!0}},function(n,t){$((function(){return $("section.hero .greeting a.whatisthis").click((function(n){return n.preventDefault(),hero_setMode("interact-card-1")}))}))},function(n,t){$((function(){return $("section.hero .interact .card.card-1 button").on("click keypress",(function(n){return hero_setMode("interact-card-2")})),$("section.hero .interact .card.card-2 button").on("click keypress",(function(n){return hero_setMode("interact-card-3")})),$("section.hero .interact .card.card-3 button").on("click keypress",(function(n){return hero_setMode("interact-card-4")})),$("section.hero .interact .card.card-4 button").on("click keypress",(function(n){return hero_setMode("greeting")}))}))},function(n,t){$((function(){return $.ajax("/captcha/generate",{success:function(n,t,e){var o,r,a,c,i;for($("section.contact form .captcha span").html(n.q),$("section.contact form .captcha input").attr("aria-label","Answer this question: "+n.q),i=[],r=0,a=(c=n.a).length;r<a;r++)o=c[r],i.push($("section.contact form").append(`<input type='hidden' name='captcha_answer[]' value='${o}'>`));return i},error:function(n,t,e){return console.log("Error while getting captcha: "+t)}})})),window.contact_beforeSubmit=function(n){return $("section.contact form button").prop("disabled","true"),$("section.contact form button > *").not(".loading").css("opacity","0"),$("section.contact form button .loading").css("opacity","1")},window.contact_success=function(n,t,e){return $("section.contact form .fields").css("opacity","0").attr("aria-hidden","true"),$("section.contact form input, section.contact form textarea, section.contact form button").attr("tabindex","-1"),sr_status("yes sir"),$("section.contact form .success").css({opacity:"1","z-index":"2"})},window.contact_error=function(n,t,e){return $("section.contact form button").prop("disabled",""),$("section.contact form button > *").not(".error").css("opacity","0"),$("section.contact form button .error").css("opacity","1").html(n.responseJSON.msg),sr_status(n.responseJSON.msg)}},function(n,t,e){"use strict";e.r(t);e(0),e(1),e(2),e(3),e(4),e(5),e(6),e(7),e(8);window.hero_setMode=function(n){return $("section.hero").removeClassMatching(/mode-/).addClass("mode-"+n)};e(9)}]);