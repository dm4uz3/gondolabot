#!/bin/bash
# needs find, ffmpeg, and rename 

# twitter only takes mp4s so gotta convert first
for i in *.webm;
  do name=`echo $i | cut -d'.' -f1`;
  ffmpeg -i "$i" "${name}.mp4";
done
rm *.webm

# because of symlinks and shit some of the videos are empty so get rid of those as well
find . -name "*" -size -5k -delete

# videos gotta be <=140s long so cut them up
for i in *.mp4;
  do name=`echo $i | cut -d'.' -f1`;
  ffmpeg -i "$i" -c copy -t 140 "${name}-trimmed.mp4";
done

# and then delete the old ones
find . -type f ! -name '*-trimmed.mp4' -delete
rename 's/-trimmed//' *-trimmed.mp4

echo "done :D :D :D"
