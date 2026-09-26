import test from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';

const core=readFileSync(new URL('../src/legacy/01-core.js',import.meta.url),'utf8');
const html=readFileSync(new URL('../index.html',import.meta.url),'utf8');

test('phone startup enters orientation mode without a sensor probe',()=>{
  const block=core.slice(core.indexOf('(function autoStartOrient(){'),core.indexOf('})();(function initLocationByTimezone'));
  assert.match(block,/const mobile=/);
  assert.match(block,/if\(api&&\(!iphone\|\|typeof api\.requestPermission!=="function"\)\)enableOrient\(\)/);
  assert.doesNotMatch(block,/deviceorientationabsolute|Lagesensor wird geprüft|setTimeout\(\(\)=>finish/);
});

test('iOS permission is deferred to the first user gesture',()=>{
  const block=core.slice(core.indexOf('(function autoStartOrient(){'),core.indexOf('})();(function initLocationByTimezone'));
  assert.match(html,/id="orient-ios-enable"/);
  assert.match(block,/showIOSOrientPermission\(true,"📱 iPhone-Sensor aktivieren"\)/);
  assert.doesNotMatch(block,/document\.addEventListener\("pointerdown"/);
  assert.match(core,/function requestIOSOrientPermission\(\)[\s\S]*api\.requestPermission\(\)\.then/);
  assert.match(core,/orient-ios-enable[\s\S]*addEventListener\("click",requestIOSOrientPermission\)/);
});

test('the Apple permission control is restricted to an actual iPhone runtime',()=>{
  assert.match(core,/function isIPhoneRuntime\(\)\{return \/iPhone\|iPod\/i\.test\(navigator\.userAgent\|\|""\)\}/);
  assert.match(core,/if\(isIPhoneRuntime\(\)&&typeof DeviceOrientationEvent!=="undefined"/);
  assert.match(core,/else if\(iphone\)showIOSOrientPermission\(true,"📱 iPhone-Sensor aktivieren"\)/);
});

test('startup has no sensor-check overlay',()=>{
  assert.doesNotMatch(html,/sensor-starting|id="sensor-start"|Lagesensor wird geprüft/);
});
