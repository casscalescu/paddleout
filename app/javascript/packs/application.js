import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css';
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';
import { initMapbox } from '../plugins/init_mapbox';
import { initAutoCompleteField } from '../plugins/init_autocomplete';
import 'flatpickr/dist/flatpickr.css';
import { toggleDateInputs } from '../components/booking';
import { loadDynamicBannerText } from '../components/banner';

toggleDateInputs('#booking_start_date');
initMapbox();
initAutoCompleteField('#surfboard_location');
loadDynamicBannerText();
