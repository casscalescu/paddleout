import places from 'places.js';

const initAutoCompleteField = (selector) => {
  const input = document.getElementById('surfboard_location');
  if(input) {
    var placesAutocomplete = places({
      appId: 'pl0S1BCHOV2L',
      apiKey: 'f6ee5094a791f6a364277c453e586b55',
      container: input,
      useDeviceLocation: true
    });
  placesAutocomplete.search();
  placesAutocomplete.on('change', e => console.log(e.suggestion));
  }
};

export { initAutoCompleteField };
