!function(t){var e={};function n(o){if(e[o])return e[o].exports;var r=e[o]={i:o,l:!1,exports:{}};return t[o].call(r.exports,r,r.exports,n),r.l=!0,r.exports}n.m=t,n.c=e,n.d=function(t,e,o){n.o(t,e)||Object.defineProperty(t,e,{enumerable:!0,get:o})},n.r=function(t){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(t,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(t,"__esModule",{value:!0})},n.t=function(t,e){if(1&e&&(t=n(t)),8&e)return t;if(4&e&&"object"==typeof t&&t&&t.__esModule)return t;var o=Object.create(null);if(n.r(o),Object.defineProperty(o,"default",{enumerable:!0,value:t}),2&e&&"string"!=typeof t)for(var r in t)n.d(o,r,function(e){return t[e]}.bind(null,r));return o},n.n=function(t){var e=t&&t.__esModule?function(){return t.default}:function(){return t};return n.d(e,"a",e),e},n.o=function(t,e){return Object.prototype.hasOwnProperty.call(t,e)},n.p="",n(n.s=6)}([function(t,e){window.xcall=function(t,...e){return"function"==typeof t?t.apply(t,e):"string"==typeof t&&window[t]?window[t].apply(window[t],e):void 0},window.sigmoid=t=>1/(1+Math.exp(-t)),window.sleep=function(t){return new Promise((function(e){return window.setTimeout(e,t)}))}},function(t,e){$.fn.removeClassMatching=function(t){return this.removeClass((function(e,n){return n.split(" ").filter((function(e){return t.test(e)})).join(" ")})),this}},function(t,e){$((function(){return document.documentElement.style.setProperty("--js-scroll-x",Math.max(window.scrollX/$(window).width(),0)),document.documentElement.style.setProperty("--js-scroll-y",Math.max(window.scrollY/$(window).height(),0)),$(window).scroll((function(t){return document.documentElement.style.setProperty("--js-scroll-x",Math.max(window.scrollX/$(window).width(),0)),document.documentElement.style.setProperty("--js-scroll-y",Math.max(window.scrollY/$(window).height(),0))})),document.documentElement.style.setProperty("--js-aspect-ratio",$(window).width()/$(window).height()),$(window).resize((function(t){return document.documentElement.style.setProperty("--js-aspect-ratio",$(window).width()/$(window).height())}))}))},function(t,e){var n;$((function(){return $("form").submit(n)})),n=function(t){var e;return t.preventDefault(),xcall(t.target.dataset.hookBeforeSubmit,t),e=new FormData(t.target),$.ajax(t.target.action,{method:t.target.method,processData:!1,contentType:!1,data:e,dataType:"json",success:function(e,n,o){return xcall(t.target.dataset.hookSuccess,e,n,o)},error:function(e,n,o){return xcall(t.target.dataset.hookError,e,n,o)}}),!1}},function(t,e){window.sevenseg=function(t,e=null){var n,o;for(n=o=0;o<=9;n=++o)$(t).removeClass("show-"+n);if(null!=e)return $(t).addClass("show-"+e)}},function(t,e){window.sr_status=function(t){return $(".sr-only.status").html(t)}},function(t,e,n){"use strict";n.r(e);n(0),n(1),n(2),n(3),n(4),n(5)}]);