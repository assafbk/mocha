file=sketches_video1.mp4
target_size=$(( 25 * 1000 * 1000 * 8 )) # 25MB in bits
length=`ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 $file`
length_round_up=$(( ${length%.*} + 1 ))
total_bitrate=$(( $target_size / $length_round_up ))
audio_bitrate=$(( 128 * 1000 )) # 128k bit rate
video_bitrate=$(( $total_bitrate - $audio_bitrate ))
ffmpeg -i "$file" -b:v $video_bitrate -maxrate:v $video_bitrate -bufsize:v $(( $target_size / 20 )) -b:a $audio_bitrate output.mp4
