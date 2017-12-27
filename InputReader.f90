!D.6. InputReader.f90
module InputReaderModule
    use NumberKinds
    use LoggerModule
    implicit none

    private
    public InputReader
    public New, Delete, assignment(=)
    public Read
    save

    type InputReader
        private
        integer(KINT)                                                           :: fileUnit
    end type InputReader

    ! Overloaded procedure interfaces
    interface New
        module procedure NewPrivate
    end interface New
    
    interface Delete
        module procedure DeletePrivate
    end interface Delete
    
    interface Read
        module procedure ReadInteger, ReadReal
    end interface Read
    
    ! Defines
    integer(KINT), parameter                                                    :: MAX_LINE_LENGTH = 256
    
    ! Logging
    type (Logger)                                                               :: log
    integer(KINT), parameter                                                    :: LOGGING_LEVEL = WARNING_LOGGING_LEVEL
    
contains

    ! ------------------------
    ! Logging.
    ! ------------------------
    subroutine InitLogger()
        ! This routine is called from the constructor to initialize the Logger.
        logical, save                                                           :: loggerInitialized = .false.
        if ( .not. loggerInitialized ) then
            call New(log, LOGGING_LEVEL)
            loggerInitialized = .true.
        end if
    end subroutine InitLogger

    ! ------------------------
    ! Standard ADT Methods. Construction, Destruction, Copying, and Assignment.
    ! ------------------------
    subroutine NewPrivate(self, fileUnit)
        type (InputReader), intent(out)                                         :: self
        integer(KINT), intent(in)                                               :: fileUnit
        self%fileUnit = fileUnit
        call InitLogger
    end subroutine NewPrivate
    
    subroutine DeletePrivate(self)
        type (InputReader), intent(inout)                                       :: self
    end subroutine DeletePrivate

    ! ------------------------
    ! Accessors.
    ! ------------------------
    function GetFileUnit(self)
        type (InputReader), intent(in)                                          :: self
        integer(KINT) :: GetFileUnit
        GetFileUnit = self%fileUnit
    end function GetFileUnit

    ! ------------------------
    ! Other methods.
    ! ------------------------
    subroutine ExtractValueString(self, key, valueString)
        type (InputReader), intent(in)                                          :: self
        character(len=*), intent(in)                                            :: key
        character(len=*), intent(out)                                           :: valueString
        character(len=MAX_LINE_LENGTH)                                          :: line
        integer(KINT)                                                           :: i, iostat
        logical                                                                 :: endOfRead

        call LogMessage(log, TRACE_LOGGING_LEVEL, 'Entered ExtractValueString')
        call LogMessage(log, DEBUG_LOGGING_LEVEL, 'key: ' // key)
        
        ! Locate the line with the right key
        endOfRead = .false.
        rewind(self%fileUnit)
        do while ( .not. LineMatchesKey() .and. .not. endOfRead )
            read(self%fileUnit, '(a)', iostat=iostat) line
            endOfRead = (iostat /= 0)
            call LogMessage(log, DEBUG_LOGGING_LEVEL, 'Line read: ' // trim(line))
        enddo

        ! Read value
        if ( LineMatchesKey() ) then
            i = index(line, ':') ! Index of colon in line
            valueString = line(i+1:) ! Copy everything after colon into value
            call LogMessage(log, DEBUG_LOGGING_LEVEL, 'Line matched key with value: '//&
                trim(valueString))
        else
            valueString = ''
            call LogMessage(log, DEBUG_LOGGING_LEVEL, 'No line matched key')
        endif
        
        call LogMessage(log, TRACE_LOGGING_LEVEL, 'Exiting ExtractValueString')

    contains

        logical function LineMatchesKey()
            integer(KINT) :: s
            s = len(key)
            if ( len(line) < s + 1 ) then
                LineMatchesKey = .false.
            else if ( line(1:s) /= key ) then
                LineMatchesKey = .false.
            else if ( line(s+1:s+1) /= ':' ) then
                LineMatchesKey = .false.
            else
                LineMatchesKey = .true.
            endif
        end function LineMatchesKey

    end subroutine ExtractValueString

    logical function ReadInteger(self, key, value)
        type (InputReader), intent(in)                                          :: self
        character(len=*), intent(in)                                            :: key
        integer(KINT), intent(inout)                                            :: value

        character(len=MAX_LINE_LENGTH)                                          :: valueString

        call ExtractValueString(self, key, valueString)
        if ( valueString == '' ) then
            ReadInteger = .false.
            return
        else
            ReadInteger = .true.
            read(valueString, *) value
        endif
    end function ReadInteger
    
    logical function ReadReal(self, key, value)
        type (InputReader), intent(in)                                          :: self
        character(len=*), intent(in)                                            :: key
        real(KREAL), intent(inout)                                              :: value

        character(len=MAX_LINE_LENGTH)                                          :: valueString

        call ExtractValueString(self, key, valueString)
        if ( valueString == '' ) then
            ReadReal = .false.
            return
        else
            ReadReal = .true.
            read(valueString, *) value
        endif

    end function

end module InputReaderModule