function slBusOut = PointStamped(msgIn, slBusOut, varargin)
%#codegen
%   Copyright 2021 The MathWorks, Inc.
    currentlength = length(slBusOut.Header);
    for iter=1:currentlength
        slBusOut.Header(iter) = bus_conv_fcns.ros.msgToBus.std_msgs.Header(msgIn.Header(iter),slBusOut(1).Header(iter),varargin{:});
    end
    slBusOut.Header = bus_conv_fcns.ros.msgToBus.std_msgs.Header(msgIn.Header,slBusOut(1).Header,varargin{:});
    currentlength = length(slBusOut.Point);
    for iter=1:currentlength
        slBusOut.Point(iter) = bus_conv_fcns.ros.msgToBus.geometry_msgs.Point(msgIn.Point(iter),slBusOut(1).Point(iter),varargin{:});
    end
    slBusOut.Point = bus_conv_fcns.ros.msgToBus.geometry_msgs.Point(msgIn.Point,slBusOut(1).Point,varargin{:});
end
