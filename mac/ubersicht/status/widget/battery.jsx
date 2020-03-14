import {run} from 'uebersicht';

let style = {
  display: 'inline-block',
  paddingRight: '12px',
};

let status = '';
const regexp = /([0-9]+%);\s*(charged|charging|discharging)/g;
const icons = {charged: '⚡️', charging: '🔌', discharging: '🔋'};
function BatteryStatus() {
  return run('pmset -g batt').then(function (output) {
    const match = regexp.exec(output);
    if (match != null) {
      status = `${icons[match[2]]} ${match[1]}`;
    }
    window.setTimeout(BatteryStatus, 1000);
  });
};
BatteryStatus();

function Battery() {
  return (
    <div style={style}>{status}</div>
  );
}
export default Battery;
