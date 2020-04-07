#=
@author Alvaro Lucas Castillo Calabacero
contact alvarolucascc96@gmail.com
=#

#=
Recursive algorithm for resolve MergeSort
=#
function mergeSort!(array, start = 1, finish = length(array))
    if start < finish
        middle = div(start+finish, 2)
        mergeSort!(array, start, middle)
        mergeSort!(array, middle+1, finish)
        merge(array, start, middle, finish)
    end
    return array
end

#=
algorithm for merge
 =#
function merge(array, start, half, finish)
    ward = typemax(eltype(array))
    leftSubArray = array[start:half]
    rightSubArray = array[(half+1):finish]
    push!(leftSubArray, ward)
    push!(rightSubArray, ward)
    auxLeft=1
    auxRight = 1
    for i in start:finish
      if leftSubArray[auxLeft] <= rightSubArray[auxRight]
          array[i] = leftSubArray[auxLeft]
          auxLeft += 1
      else
          array[i] = rightSubArray[auxRight]
          auxRight += 1
      end
    end
end
#can change this total numbers for process of sort
totalNumbers = 1000;
list = [rem(rand(Int32),10) for i =1:totalNumbers]

print("Sorted List in :")
#get time to solve whit secuencial algorithm
@time mergeSort!(list)
print(list)
