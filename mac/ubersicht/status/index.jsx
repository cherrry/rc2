import Battery from './widget/battery.jsx';
import Clock from './widget/clock.jsx';

export const command = 'true';
export const refreshFrequency = 17;
export const render = () => (
  <div>
    <div style={{position: 'absolute', right: '12px'}}>
      <Battery />
      <Clock />
    </div>
  </div>
);

export const className = `
  left: 0;
  top: 0;
  width: 100%;
  height: 26px;
  background-color: #181818;
  color: #f8f8f8;
  line-height: 26px;
  font-family: 'Helvetica';
  font-size: 12px;
  vertical-align: middle;
  display: flex;
`;
