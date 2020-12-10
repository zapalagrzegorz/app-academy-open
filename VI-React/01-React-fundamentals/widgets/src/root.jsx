import React from 'react';
import { Clock } from './clock';
import { Tabs } from './tabs';

export function Root() {
  const tabs = [
    { title: 'tab1', content: 'content1' },
    { title: 'tab2', content: 'content2' },
    { title: 'tab3', content: 'content3' },
  ];
  return (
    <>
      <Clock />
      <Tabs tabs={tabs} />
    </>
  );
}
