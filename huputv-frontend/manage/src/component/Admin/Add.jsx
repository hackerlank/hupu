import React from 'react';
import Form from './Form';

class Add extends React.Component {
    render () {
        return (
            <Form {...this.props} action="add" />
        );
    }
}

export default Add;
