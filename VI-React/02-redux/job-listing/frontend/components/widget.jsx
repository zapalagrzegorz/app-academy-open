import React from 'react';
import Job from './job';
import { selectLocation, setLoading } from './../actions';

class Widget extends React.Component {
  constructor(props) {
    super(props);
    this.forceUpdate = this.forceUpdate.bind(this);

    // require this component to re-render whenever the store's state changes
    this.props.store.subscribe(this.forceUpdate);
    this.cities = ['New York', 'San Francisco', 'Los Angeles'];
    this.selectLocation = selectLocation.bind(this);
    this.setLoading = setLoading.bind(this);
  }

  fetchJobListings(city) {
    this.props.store.dispatch(this.setLoading(true));
    $.ajax({
      url: `https://79vzv34gc4.execute-api.us-west-1.amazonaws.com/default/jobListings?location=${city}`,
      type: 'GET',
      success: function (resp) {
        // tell the store to update with the new location and jobs;
        // use the action creator 'selectLocation' to build the object to
        // be dispatched
        this.props.store.dispatch(this.selectLocation(city, resp));
      }.bind(this),
    });
  }

  render() {
    // get the store's current state and deconstruct it into 'jobs'
    // and 'city' variables
    const { city, jobs, loading } = this.props.store.getState();
    const cityOptions = this.cities.map((city) => (
      <button
        onClick={() => {
          this.fetchJobListings(city);
        }}
        key={city}
        className="job-option"
      >
        {city}
      </button>
    ));

    const jobListings = jobs.map((job) => (
      <Job
        key={job.id}
        title={job.title}
        company={job.company}
        location={job.location}
        type={job.type}
        description={job.description}
        info={job.url}
      />
    ));

    const Loader = () => <div className="loader"></div>;

    const JobListingsComponent = (props) => {
      const { cityOptions, city, jobListings, loading } = props;
      return (
        <div>
          <h1>Github Job Listings</h1>
          <h3>City: {city}</h3>

          <div className="location-selector">
            Location:
            {cityOptions}
          </div>

          {loading ? (
            <Loader />
          ) : (
            <>
              <h3>{jobListings.length} Job Listings</h3>
              <ol className="listings-list">{jobListings}</ol>
            </>
          )}
        </div>
      );
    };

    return (
      <JobListingsComponent
        cityOptions={cityOptions}
        jobListings={jobListings}
        city={city}
        loading={loading}
      />
      // }
    );
  }
}

export default Widget;
