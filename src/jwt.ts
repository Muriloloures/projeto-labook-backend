import { JwtPayload } from "jsonwebtoken";
import jwt  from "jsonwebtoken";

  const secretKey = "murilo";

export const generateToken = (userId: string) => { 
  const payload = { id: userId };
  const token = jwt.sign(payload, secretKey);

  return token;
}; 

export const verifyToken = (token: string): JwtPayload | null => {
    try {
      const decoded = jwt.verify(token, secretKey) as JwtPayload
      ;
      return decoded;
    } catch (error) {
      return null;
    }
  }  