import React from 'react';

class Catalog extends React.Component {
    static current = 'catalog';

    render () {
        return (
            <div>
                {this.props.children}
            </div>
        );
    }
}

export default Catalog;
