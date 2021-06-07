module INTEROP
implicit none    
type :: interop_struct
    sequence
    integer :: id
    real*8 :: values(10)
    character*16 :: name
end type

contains
    
! A simple function demonstrating returning a value.
function return_integer(input) result(output)
! Don't leave the calling convention to chance.
!DEC$ ATTRIBUTES DLLEXPORT ::  RETURN_INTEGER
    
    integer*4, intent(in) :: input
    integer*4 :: output

    output = input*2

end function


function sum_array_fixed(data) result(sum)
!DEC$ ATTRIBUTES DLLEXPORT :: SUM_ARRAY_FIXED
    !real*8 :: x1,y1,z1
    real*8, intent(in) :: data(10)
    real*8 :: sum
    integer :: i
    type(interop_struct) :: dat
    
    sum = 0
    do i = 1, 10
        sum = sum + data(i)
    end do
    
    sum = sum
    
end function

end module INTEROP