import { randomBytes } from 'crypto';

// Generate a 64-byte random hex string
const secretKey = randomBytes(64).toString('hex');
console.log('Generated Secret Key:', secretKey);
