import moment from 'moment';
import tz from 'moment-timezone';

const HKG = 'Asia/Hong_Kong';
const MTV = 'America/Los_Angeles';
const NYC = 'America/New_York';
const DUB = 'Europe/Dublin';

const list = {
  padding: 0,
  margin: 0,
  listStyleType: 'none',
  display: 'inline-block',
};

const item = { display: 'inline-block', minWidth: '8px' };

function Now() {
  const time = moment();
  return {
    fmt: (timezone, format='HH:mm') => (
      time.clone().tz(timezone).format(format)
    ),
  };
}

function Clock() {
  const now = Now();
  return (
    <ul style={list}>
      <li style={item}>🗓 {now.fmt(HKG, 'Do MMM, YYYY (ddd)')}</li>
      <li style={item}></li>
      <li style={item}>🌏 {now.fmt(HKG)}</li>
      <li style={item}></li>
      <li style={item}>🌎 {now.fmt(MTV)} / {now.fmt(NYC)}</li>
    </ul>
  );
};

export default Clock;
