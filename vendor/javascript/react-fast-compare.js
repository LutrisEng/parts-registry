var e={};var r="undefined"!==typeof Element;var t="function"===typeof Map;var n="function"===typeof Set;var f="function"===typeof ArrayBuffer&&!!ArrayBuffer.isView;function equal(e,a){if(e===a)return true;if(e&&a&&"object"==typeof e&&"object"==typeof a){if(e.constructor!==a.constructor)return false;var u,i,o;if(Array.isArray(e)){u=e.length;if(u!=a.length)return false;for(i=u;0!==i--;)if(!equal(e[i],a[i]))return false;return true}var s;if(t&&e instanceof Map&&a instanceof Map){if(e.size!==a.size)return false;s=e.entries();while(!(i=s.next()).done)if(!a.has(i.value[0]))return false;s=e.entries();while(!(i=s.next()).done)if(!equal(i.value[1],a.get(i.value[0])))return false;return true}if(n&&e instanceof Set&&a instanceof Set){if(e.size!==a.size)return false;s=e.entries();while(!(i=s.next()).done)if(!a.has(i.value[0]))return false;return true}if(f&&ArrayBuffer.isView(e)&&ArrayBuffer.isView(a)){u=e.length;if(u!=a.length)return false;for(i=u;0!==i--;)if(e[i]!==a[i])return false;return true}if(e.constructor===RegExp)return e.source===a.source&&e.flags===a.flags;if(e.valueOf!==Object.prototype.valueOf)return e.valueOf()===a.valueOf();if(e.toString!==Object.prototype.toString)return e.toString()===a.toString();o=Object.keys(e);u=o.length;if(u!==Object.keys(a).length)return false;for(i=u;0!==i--;)if(!Object.prototype.hasOwnProperty.call(a,o[i]))return false;if(r&&e instanceof Element)return false;for(i=u;0!==i--;)if(("_owner"!==o[i]&&"__v"!==o[i]&&"__o"!==o[i]||!e.$$typeof)&&!equal(e[o[i]],a[o[i]]))return false;return true}return e!==e&&a!==a}e=function isEqual(e,r){try{return equal(e,r)}catch(e){if((e.message||"").match(/stack|recursion/i)){console.warn("react-fast-compare cannot handle circular refs");return false}throw e}};var a=e;export default a;

