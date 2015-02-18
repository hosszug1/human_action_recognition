function throwException(locationOfException, message)
%THROWEXCEPTION Summary of this function goes here
%   Detailed explanation goes here

msgID = locationOfException;
msg = message;
baseException = MException(msgID, msg);

throw(baseException);

end

