import { Calendar } from '@fullcalendar/core';
import interactionPlugin from '@fullcalendar/interaction';
import timeGridPlugin from '@fullcalendar/timegrid';

document.addEventListener("DOMContentLoaded", function() {
    let calendarEl = document.getElementById('slot-picker');

    let today = new Date();
    let endOfNextMonth = new Date(today.getFullYear(), today.getMonth() + 2, 0);

    function isWeekend(date) {
        let dayOfWeek = date.getDay();
        return (dayOfWeek === 6 || dayOfWeek === 0);
    }

    let calendar = new Calendar(calendarEl, {
        plugins: [ timeGridPlugin, interactionPlugin ],
        headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'timeGridWeek,timeGridDay'
        },
        initialView: 'timeGridWeek',
        firstDay: 1,
        slotMinTime: '08:00:00',
        height: 920,
        selectable: true,
        // hiddenDays: [0, 6],
        dayHeaderFormat: { weekday: 'long', month: 'short', day: 'numeric' },
        titleFormat: { month: 'long', year: 'numeric' },
        selectAllow: function(selectInfo) {
            let start = new Date(selectInfo.start);
            let end = new Date(selectInfo.end);

            if (isWeekend(start) || isWeekend(end)) {
                return false;
            }

            if (start < today) {
                return false;
            }

            let duration = (end - start) / (1000 * 60 * 60);
            return duration <= 3;
        },
        select: function(info) {
            let duration = (info.end - info.start) / (1000 * 60 * 60); // длительность в часах
            if (duration > 1) {
                alert('Внимание! Вы выбрали интервал продолжительностью больше 1 часа. Вы выбрали время с ' + info.startStr + ' до ' + info.endStr);
                // calendar.unselect(); // Отменить выбор
                // return;
            }

            document.getElementById('start_time').value = info.startStr;
            document.getElementById('end_time').value = info.endStr;
        },
        events: '/availability_slots.json',
        validRange: {
            start: today.toISOString(),
            end: endOfNextMonth.toISOString()
        },
    });

    calendar.render();
});
