   
subroutine TASS(cpfx, cpfy)
!DEC$ ATTRIBUTES DLLEXPORT::TASS
   use, intrinsic :: iso_c_binding
   implicit none
   real(kind=8), target :: x, y
   integer(c_int) :: ix, iy
   !integer(c_int) :: ix, iy
   real(c_double), pointer :: pfx, pfy
   common /COMBLK/ x, y
   common /COMINT/ ix, iy
   !BIND(C) :: /COMINT/, /COMBLK/
   type(c_ptr) :: cpfx, cpfy   
   
   pfx => x
   pfy => y
   
   cpfx = c_loc(pfx)
   cpfy = c_loc(pfy)
   
   x = 1001.0
   y =-25.0
   
   ix = 5
   iy = -3
   
   print*, "Here in InterFort"
   

end subroutine TASS

subroutine Simulation(alpha, beta, gamma, delta, arrays) BIND(C,name="SIMULATION") 
!DEC$ ATTRIBUTES DLLEXPORT::SIMULATION
   use, intrinsic :: ISO_C_BINDING 
   implicit none 
   integer (C_LONG), value :: alpha 
   real (C_DOUBLE), intent(inout) :: beta 
   integer (C_LONG), intent(out) :: gamma 
   real (C_DOUBLE),dimension(*),intent(in) :: delta
   type, BIND(C) :: pass 
      integer (C_INT) :: lenc, lenf
      type (C_PTR) :: c, f 
   end type pass 
   type (pass), intent(inout) :: arrays
   real (C_FLOAT), ALLOCATABLE, target, save :: eta(:)
   real (C_FLOAT), pointer :: c_array(:) 

   ! Associate c_array with an array allocated in C 
   call C_F_POINTER (arrays%c, c_array, (/arrays%lenc/) ) 

   ! Allocate an array and make it available in C 
   arrays%lenf = 100 
   ALLOCATE (eta(arrays%lenf)) 
   arrays%f = c_loc(eta) 

end subroutine Simulation

    
module ftn_C_2
   interface 
     integer (C_INT) function C_Library_Function & 
     (sendbuf, sendcount, recvcounts) & 
        BIND(C, name='C_Library_Function')
        use, intrinsic :: ISO_C_BINDING  
        implicit none 
        type (C_PTR), value :: sendbuf 
        integer (C_INT), value :: sendcount 
        type (C_PTR), value :: recvcounts 
     end function C_Library_Function 
   end interface 
end module ftn_C_2