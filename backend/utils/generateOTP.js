import { customAlphabet } from 'nanoid';

export default function generateOTP() {
  return customAlphabet('123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ', 4)
};