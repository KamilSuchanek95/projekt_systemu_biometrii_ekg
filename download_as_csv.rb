
f = File.open('RECORDS','r')
f.each_line { |person_record|
str = person_record.strip
command = 'rdsamp -r ecgiddb/' + str + ' -c -H -f 0 -t 20 -v -pS >' + str + '.csv'
system command
sleep 0.5
command = 'rm ' + str + '.atr ' + str + '.dat ' + str + '.hea '
system command
}
