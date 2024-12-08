import { customAlphabet } from 'nanoid';

export default function generateOTP() {
  const generate = customAlphabet('123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ', 4);
  return generate;
};