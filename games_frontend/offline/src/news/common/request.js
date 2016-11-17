import dataService from 'common/dataService';
import {protocol, host} from './config';

const API_BASE = `${protocol}://${host}`

export default dataService(API_BASE)
