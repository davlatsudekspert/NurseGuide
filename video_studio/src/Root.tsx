import React from 'react';
import {Composition} from 'remotion';
import {NurseVideo, type VideoProps} from './Video';
import {OVERVIEW, REEL} from './content';

const total = (d: number[]) => Math.round(d.reduce((a, b) => a + b, 0) * 30);
const fallback = (n: number, s: number) => Array(n).fill(s);

export const Root: React.FC = () => (
  <>
    {(['16x9', '9x16'] as const).map((fmt) => (
      <Composition
        key={fmt}
        id={`overview-${fmt}`}
        component={NurseVideo as React.FC<any>}
        width={fmt === '16x9' ? 1920 : 1080}
        height={fmt === '16x9' ? 1080 : 1920}
        fps={30}
        durationInFrames={total(fallback(OVERVIEW.length, 8))}
        defaultProps={{scenes: OVERVIEW, durations: fallback(OVERVIEW.length, 8), lang: 'uz', vertical: fmt === '9x16'} satisfies VideoProps}
        calculateMetadata={({props}) => ({durationInFrames: total((props as unknown as VideoProps).durations)})}
      />
    ))}
    <Composition
      id="reel-9x16"
      component={NurseVideo as React.FC<any>}
      width={1080}
      height={1920}
      fps={30}
      durationInFrames={total(fallback(REEL.length, 7))}
      defaultProps={{scenes: REEL, durations: fallback(REEL.length, 7), lang: 'all', vertical: true} satisfies VideoProps}
      calculateMetadata={({props}) => ({durationInFrames: total((props as unknown as VideoProps).durations)})}
    />
  </>
);
