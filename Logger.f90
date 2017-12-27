!D.7. Logger.f90
module LoggerModule
    use NumberKinds
    use OutputWriterModule
    implicit none
    
    private
    public Logger, New, Delete, Assignment(=), OutputProperties, LogMessage
    public DEBUG_LOGGING_LEVEL, TRACE_LOGGING_LEVEL, WARNING_LOGGING_LEVEL, ERROR_LOGGING_LEVEL
    save
    
    type Logger
        private
        integer(KINT)                                                       :: level
    end type Logger

    ! Overloaded procedure interfaces
    interface New
        module procedure NewPrivate, NewCopyPrivate
    end interface New
    
    interface Delete
        module procedure DeletePrivate
    end interface Delete
    
    interface Assignment(=)
        module procedure AssignPrivate
    end interface Assignment(=)
    
    interface OutputProperties
        module procedure OutputPropertiesPrivate
    end interface OutputProperties

    interface LogMessage
        module procedure LogMessageReal, LogMessageInteger, LogMessageIntegerArray
        module procedure LogMessageRealArray, LogMessageTextOnly
    end interface LogMessage
    
    ! Definitions
    integer(KINT), parameter                                                :: DEBUG_LOGGING_LEVEL = 1
    integer(KINT), parameter                                                :: TRACE_LOGGING_LEVEL = 2
    integer(KINT), parameter                                                :: WARNING_LOGGING_LEVEL = 3
    integer(KINT), parameter                                                :: ERROR_LOGGING_LEVEL = 4

contains

    ! ------------------------
    ! Standard ADT Methods. Construction, Destruction, Copying, and Assignment.
    ! ------------------------
    subroutine NewPrivate(self,level)
        type (Logger), intent(out)                                          :: self
        integer(KINT), intent(in)                                           :: level
        self%level = level
    end subroutine NewPrivate

    subroutine NewCopyPrivate(self, other)
        type (Logger), intent(out)                                          :: self
        type (Logger), intent(in)                                           :: other
        self%level = other%level
    end subroutine NewCopyPrivate

    subroutine DeletePrivate(self)
        type (Logger), intent(inout)                                        :: self
    end subroutine DeletePrivate
    
    subroutine AssignPrivate(self, other)
        type (Logger), intent(inout)                                        :: self
        type (Logger), intent(in)                                           :: other
        self%level = other%level
    end subroutine AssignPrivate
    
    ! ------------------------
    ! Accessors.
    ! ------------------------
    subroutine SetLevel(self, level)
        type (Logger), intent(inout)                                        :: self
        integer(KINT), intent(in)                                           :: level
        self%level = level
    end subroutine SetLevel

    function GetLevel(self)
        type (Logger), intent(in)                                           :: self
        integer(KINT)                                                       :: GetLevel
        GetLevel = self%level
    end function GetLevel
    
    ! ------------------------
    ! Other methods.
    ! ------------------------
    subroutine LogMessageTextOnly(self, level, text)
    type (Logger)                                                           :: self
    integer(KINT)                                                           :: level
    character(len=*)                                                        :: text
    if ( level >= self%level ) print *, 'Log: ', text
    end subroutine LogMessageTextOnly

    subroutine LogMessageReal(self, level, key, val)
        type (Logger)                                                       :: self
        integer(KINT)                                                       :: level
        character(len=*)                                                    :: key
        real(KREAL)                                                         :: val
        if ( level >= self%level ) print *, 'Log: ' // trim(key), val
    end subroutine LogMessageReal
    
    subroutine LogMessageInteger(self, level, key, val)
        type (Logger)                                                       :: self
        integer(KINT)                                                       :: level
        character(len=*)                                                    :: key
        integer(KINT)                                                       :: val
        if ( level >= self%level ) print *, 'Log: ' // trim(key), val
    end subroutine LogMessageInteger

    subroutine LogMessageIntegerArray(self, level, key, vals)
        type (Logger)                                                       :: self
        integer(KINT)                                                       :: level
        character(len=*)                                                    :: key
        integer(KINT)                                                       :: vals(:)
        if ( level >= self%level ) then
            print *, 'Log: ' // trim(key)
            print *, vals
        endif                                                       
    end subroutine LogMessageIntegerArray

    subroutine LogMessageRealArray(self, level, key, vals)
        type (Logger)                                                       :: self
        integer(KINT)                                                       :: level
        character(len=*)                                                    :: key
        real(KREAL)                                                         :: vals(:)
        if ( level >= self%level ) then
            print *, 'Log: ' // trim(key)
            print *, vals
        endif
    end subroutine LogMessageRealArray

    ! ------------------------
    ! Output properties.
    ! ------------------------
    subroutine OutputPropertiesPrivate(self, writer)
        type (Logger), intent(in)                                           :: self
        type (OutputWriter), intent(inout)                                  :: writer

        call Write(writer, 'Logging Level', self%level)

    end subroutine OutputPropertiesPrivate

end module LoggerModule