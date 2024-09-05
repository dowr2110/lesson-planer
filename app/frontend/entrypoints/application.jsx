// imports for js and css
import '../styles/application.scss'
import '../packs/lessons.js'
import '../packs/slot-picker.js'
import '../packs/student-calendar.js'

// React
import React from 'react';
import ReactDOM from 'react-dom/client';
import TestComponent from '../components/TestComponent.jsx';

const COMPONENTS = {
    TestComponent,
};

document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('[data-react-component]').forEach(node => {
        const componentName = node.getAttribute('data-react-component');
        const Component = COMPONENTS[componentName];

        if (Component) {
            const props = JSON.parse(node.getAttribute('data-react-props') || '{}');
            const root = ReactDOM.createRoot(node);
            root.render(<Component {...props} />);
        }
    });
});

//Rails
import Rails from "@rails/ujs";
Rails.start();