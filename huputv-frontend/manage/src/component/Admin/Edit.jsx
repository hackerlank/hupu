import React from 'react';
import Form from './Form';

class Edit extends React.Component {
    render () {
        return (
            <Form {...this.props} action="edit" />
        );
    }
}

export default Edit;
