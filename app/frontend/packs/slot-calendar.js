import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';

document.addEventListener('DOMContentLoaded', function() {
    let calendarEl = document.getElementById('student-calendar');

    let today = new Date();
    let endOfNextMonth = new Date(today.getFullYear(), today.getMonth() + 2, 0);

    function openModal(info) {
        document.getElementById('modalStartTime').textContent = info.startStr;
        document.getElementById('modalEndTime').textContent = info.endStr;
        document.getElementById('modalDescription').textContent = info.extendedProps.description || 'No description';
        if (info.extendedProps.teacher === true && info.title === 'Available') {
            let deleteLink = document.getElementById('slot-delete-link')
            deleteLink.innerHTML = 'Delete Slot';
            deleteLink.href = '/availability_slots/' + info.extendedProps.availability_slot_id;
            deleteLink.setAttribute('data-confirm', 'Are you sure?');
            deleteLink.setAttribute('data-method', 'delete');
        }
        else if (info.extendedProps.teacher === true && info.title === 'Booked') {
            let deleteLink = document.getElementById('slot-delete-link')
            deleteLink.innerHTML = '';
            deleteLink.href = ''
        }
        else if(info.extendedProps.teacher === false){
            document.getElementById('availability_slot').value = info.extendedProps.availability_slot_id
        }
        else if(info.extendedProps.zoom_link !== null){
            let zoomLink = document.getElementById('modalZoomLink')
            zoomLink.href = info.extendedProps.zoom_link;
        }

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

            if(event.extendedProps.teacher === true) {
                openModal(event)
            }
            else {
                if (event.title === 'Booked') {
                    // alert('Этот слот заблокирован и не доступен для выбора.');
                    // info.jsEvent.preventDefault();
                    openModal(event)
                }
                else if (event.extendedProps.overlapped === true) {
                    alert('Этот слот пересекается с твоим забуканным');
                    info.jsEvent.preventDefault();
                } else {
                    openModal(event)
                }
            }
        }
    });
    calendar.render();
});
