%YUV2RGB	Convert YUV format to RGB
%
%	[r,g,b] = yuvread2(y, u, v)
%	rgb = yuvread(y, u, v)
%
%	Returns the equivalent RGB image from YUV components.  The UV images are
%	doubled in resolution so the resulting color image is original size.
%



% Copyright (C) 1993-2011, by Peter I. Corke
%
% This file is part of The Machine Vision Toolbox for Matlab (MVTB).
% 
% MVTB is free software: you can redistribute it and/or modify
% it under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% MVTB is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU Lesser General Public License for more details.
% 
% You should have received a copy of the GNU Leser General Public License
% along with MVTB.  If not, see <http://www.gnu.org/licenses/>.
function [R,G,B] = yuv2rgb2(y, u2, v2)

	% subsample, probably should smooth first...
	u = zeros(2*size(u2));
	v = zeros(2*size(v2));

	for i=1:4,
		u(1:2:end,1:2:end) = u2;
		v(1:2:end,1:2:end) = v2;

		u(2:2:end,1:2:end) = u2;
		v(2:2:end,1:2:end) = v2;

		u(1:2:end,2:2:end) = u2;
		v(1:2:end,2:2:end) = v2;

		u(2:2:end,2:2:end) = u2;
		v(2:2:end,2:2:end) = v2;
	end

	Cr = u - 128;
	Cb = v - 128;

	% convert to RGB
	r = (y + 1.366*Cr - 0.002*Cb);
	g = (y - 0.700*Cr - 0.334*Cb);
	b = (y - 0.006*Cr + 1.732*Cb);

	% clip the values into range [0, 255]
	r = max(0, min(r, 255));
	g = max(0, min(g, 255));
	b = max(0, min(b, 255));

	if nargout == 1,
		R(:,:,1) = r;
		R(:,:,2) = g;
		R(:,:,3) = b;
	else
		R = r;
		G = g;
		B = b;
	end
