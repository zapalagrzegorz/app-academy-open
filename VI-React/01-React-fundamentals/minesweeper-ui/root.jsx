import React from 'react';
import { Autocomplete } from './components/autocomplete';
import { Clock } from './components/clock';
import { Tabs } from './components/tabs';
import { Weather } from './components/weather';
export function Root() {
  const tabs = [
    { title: 'tab1', content: 'content1' },
    { title: 'tab2', content: 'content2' },
    { title: 'tab3', content: 'content3' },
  ];

  const people = ['Abba', 'Barney', 'Jeff', 'Miranda', 'Huxley'];
  return (
    <>
      <Clock />
      <Weather />
      <div className="flex-container">
        <Tabs tabs={tabs} />
        <Autocomplete people={people} className="flex-child-grow" />
      </div>
    </>
  );
}
