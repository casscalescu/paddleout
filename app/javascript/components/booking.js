import flatpickr from 'flatpickr';

const toggleDateInputs = function(selector) {
  const startDateInput = document.getElementById('booking_start_date');
  const endDateInput = document.getElementById('booking_end_date');

  if (startDateInput && endDateInput) {
    const unavailableDates = JSON.parse(document.querySelector('.unavailable-date').dataset.unavailable);

    flatpickr(startDateInput, {
    minDate: 'today',
    dateFormat: 'Y-m-d',
    disable: unavailableDates,
    onChange: function(selectedDates, selectedDate) {
      if (selectedDate === '') {
        endDateInput.disabled = true;
      }
      let minDate = selectedDates[0];
      minDate.setDate(minDate.getDate() + 1);
      endDateCalendar.set('minDate', minDate);
      endDateInput.disabled = false;
    }
  });
    const endDateCalendar =
      flatpickr(endDateInput, {
        dateFormat: 'Y-m-d',
        disable: unavailableDates,
        },
      );
  }
};

export { toggleDateInputs }
