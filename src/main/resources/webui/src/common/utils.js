import dayjs from 'dayjs'

export default class Utils {

    static formatDateTimeMS(value) {
        if (value) {
            return dayjs(value).format('YYYY-MM-DD HH:mm:ss.SSS');
        } else {
            return '0000-00-00 00:00:00.000';
        }
    }

    static formatDateTime(value) {
        if (value) {
            return dayjs(value).format('YYYY-MM-DD HH:mm:ss');
        } else {
            return '0000-00-00 00:00:00';
        }
    }

    static formatDate(value) {
        if (value) {
            return dayjs(value).format('YYYY-MM-DD');
        } else {
            return '0000-00-00';
        }
    }

    static formatTime(value) {
        if (value) {
            return dayjs(value).format('HH:mm:ss');
        } else {
            return '00:00:00';
        }
    }
}
