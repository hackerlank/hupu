import React from 'react';

export default class Task extends React.Component {
    static current = 'task';

    render () {
        return (
            <div>
                {this.props.children}
            </div>
        );
    }
}
