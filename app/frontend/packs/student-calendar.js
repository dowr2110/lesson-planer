import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';

document.addEventListener('DOMContentLoaded', function() {
    let calendarEl = document.getElementById('student-calendar');

    let today = new Date();
    let endOfNextMonth = new Date(today.getFullYear(), today.getMonth() + 2, 0);

    let calendar = new Calendar(calendarEl, {
        plugins: [dayGridPlugin, timeGridPlugin],
        initialView: 'timeGridWeek',
        firstDay: 1,
        slotMinTime: '08:00:00',
        height: 920,
        validRange: {
            start: today.toISOString(),
            end: endOfNextMonth.toISOString()
        },
        events: '/availability_slots.json',
        eventClick: function(info) {
            let event = info.event;

            if (event.title === 'Booked') {
                alert('Этот слот заблокирован и не доступен для выбора.');
                info.jsEvent.preventDefault();
            }
            else if (event.extendedProps.overlapped === true) {
                alert('Этот слот пересекается с твоим забуканным');
                info.jsEvent.preventDefault();
            } else {
                document.getElementById('modalStartTime').textContent = event.startStr;
                document.getElementById('modalEndTime').textContent = event.endStr;
                document.getElementById('modalDescription').textContent = event.extendedProps.description || 'No description';
                document.getElementById('availability_slot').value = event.extendedProps.availability_slot_id

                let modal = document.getElementById("slotModal");
                let span = document.getElementById("closeModal");

                modal.style.display = "block";

                span.onclick = function() {
                    modal.style.display = "none";
                }
                window.onclick = function(event) {
                    if (event.target == modal) {
                        modal.style.display = "none";
                    }
                }
            }
        }
    });
    calendar.render();
});
