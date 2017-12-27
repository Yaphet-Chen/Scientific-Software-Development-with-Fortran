module GenericDataModule
    type DataType
        character(len=1) :: notused
    end type DataType
    type(DataType), parameter :: DataPrototype(1) = DataType('')
end module GenericDataModule

module PrintModule
    use GenericDataModule
contains
    subroutine PrintValues(ValueFunc, coords, data)
        real, intent(in) :: coords(:)
        integer :: i
        type(Datatype), intent(in) :: data(:)
        interface
            real function ValueFunc(x, data)
                use GenericDataModule
                real, intent(in) :: x
                type(DataType), intent(in) :: data(:)
            end function ValueFunc
        end interface
        
        do i = 1, size(coords)
            print *, ValueFunc(coords(i),data)
        enddo
    end subroutine PrintValues
end module PrintModule

module MathFuncsModule
    use GenericDataModule
    
    type CosineArgsType
        real :: wavenumber, amplitude
    end type
contains
    real function CosineFunc(x, wavenumber, amplitude)
        real, intent(in) :: x
        real, intent(in) :: wavenumber, amplitude
        CosineFunc = amplitude * cos(wavenumber * x)
    end function CosineFunc
    
    real function GenericCosineFunc(x, data)
        real, intent(in) :: x
        type(DataType), intent(in) :: data(:)
        type(CosineArgsType) :: args
        args = transfer(data, args)
        GenericCosineFunc = CosineFunc(x, args%wavenumber, args%amplitude)
    end function GenericCosineFunc
    end module MathFuncsModule

program test
    use PrintModule
    use MathFuncsModule
    use GenericDataModule
    
    real, parameter :: pi = acos(-1.)
    type(Datatype), allocatable :: data(:)
    type(CosineArgsType) :: args
    integer :: lengthData
    
    lengthData = size(transfer(args, DataPrototype))
    allocate(data(lengthData))
    args = CosineArgsType(1.0, 1.0)
    data = transfer(args, DataPrototype)
    call PrintValues(GenericCosineFunc, pi * (/ (0.25 * i, i = 0,4) /), data)
    deallocate(data)
end program test