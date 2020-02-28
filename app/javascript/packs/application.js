import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css';
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';
import { initMapbox } from '../plugins/init_mapbox';
import { initAutoCompleteField } from '../plugins/init_autocomplete';
import 'flatpickr/dist/flatpickr.css';
import { toggleDateInputs } from '../components/booking';

toggleDateInputs();
initMapbox();
initAutoCompleteField('#surfboard_location');