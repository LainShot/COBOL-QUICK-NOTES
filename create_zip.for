program create_zip
    implicit none

    ! Declare variables
    integer :: zip_file, data_file, status
    integer :: zip_header(12), zip_compressed_data(256)
    integer :: zip_footer(4)
    character(len=8) :: zip_file_name = "ZIPFILE"
    character(len=3) :: zip_file_extension = "ZIP"
    character(len=3) :: zip_file_type = "SEQ"
    character(len=8) :: zip_file_access_mode = "SEQUENTIAL"
    character(len=256) :: data_file_name
    integer :: i

    ! Prompt the user for the data file name
    print *, "Enter the data file name:"
    read *, data_file_name

    ! Open the data file
    open(unit=data_file, file=trim(data_file_name),
         access="sequential", status="unknown", form="unformatted")
    if (status /= 0) then
        print *, "Error opening data file!"
        stop
    end if

    ! Open the ZIP file
    open(unit=zip_file, file=trim(zip_file_name) // "." // trim(zip_file_extension),
         access=trim(zip_file_access_mode), status="unknown", form="unformatted")
    if (status /= 0) then
        print *, "Error opening zip file!"
        stop
    end if

    ! Initialize the ZIP header and footer
    zip_header = [4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    zip_footer = [4, 0, 0, 0]

    ! Read the data from the data file and compress it
    do i = 1, 256
        read(data_file, end=100) zip_compressed_data(i)
    end do
    goto 101
100  continue
    ! If there is not enough data, pad the compressed data with zeros
    do i = i, 256
        zip_compressed_data(i) = 0
    end do
101  continue

    ! Write the ZIP header, compressed data, and footer to the file
    write(zip_file) zip_header, zip_compressed_data, zip_footer

    ! Close the data and ZIP files
    close(data_file)
    close(zip_file)
end program create_zip
