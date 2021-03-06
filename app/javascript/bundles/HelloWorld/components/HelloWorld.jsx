import PropTypes from 'prop-types';
import React from 'react';

export default class HelloWorld extends React.Component {
  static propTypes = {
    name: PropTypes.string.isRequired, // this is passed from the Rails view
  };

  /**
   * @param props - Comes from your rails view.
   */
  constructor(props) {
    super(props);

    // How to set initial state in ES6 class syntax
    // https://facebook.github.io/react/docs/reusable-components.html#es6-classes
    this.state = { name: this.props.name };
  }

  updateName = (name) => {
    this.setState({ name });
  };

  render() {
    return (
      <div className="container">
        <h3>
          Hello, {this.state.name}!
        </h3>
        <form className="bs-component">
          <div className="form-group">
            <label htmlFor="name" className="control-label">
              Say hello to:
            </label>
            <input
                className="form-control"
                id="name"
                type="text"
                value={this.state.name}
                onChange={(e) => this.updateName(e.target.value)}
            />

          </div>
        </form>
      </div>
    );
  }
}
