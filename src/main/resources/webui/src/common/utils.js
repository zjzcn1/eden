import dayjs from 'dayjs'

export default {
    formatDateTimeMS(value) {
        if (value) {
            return dayjs(value).format('YYYY-MM-DD HH:mm:ss.SSS');
        } else {
            return '0000-00-00 00:00:00.000';
        }
    },
    formatDateTime(value) {
        if (value) {
            return dayjs(value).format('YYYY-MM-DD HH:mm:ss');
        } else {
            return '0000-00-00 00:00:00';
        }
    },
    formatDate(value) {
        if (value) {
            return dayjs(value).format('YYYY-MM-DD');
        } else {
            return '0000-00-00';
        }
    },
    formatTime(value) {
        if (value) {
            return dayjs(value).format('HH:mm:ss');
        } else {
            return '00:00:00';
        }
    }
}
