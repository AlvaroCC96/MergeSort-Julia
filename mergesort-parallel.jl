using Distributed
import Base.Threads.@spawn

#=
@author Alvaro Lucas Castillo Calabacero
contact alvarolucascc96@gmail.com
=#

# function to sort array with mergesort algorithm
function mergesort_parallel!(array, start::Int=1, finish::Int=length(array))
    # if start >= finish, nothing to do
    if start >= finish
        return array
    end
    # support 100000 numbers, and apply the MergeSort
    #this algorithm is provide for Julialang
    if finish - start < 100000
        sort!(view(array, start:finish), alg = MergeSort)
        return array
    end

    pivot = div(finish+start,2)
    #Resolve first part of array
    semiArray = @spawn mergesort_parallel!(array, start, pivot)

    #wait to finish ordering the previous half
    wait(semiArray)
    temp = array[lo:mid]
    i =1
    k =1
    j=1
    #start= pivot+1

    #merge two parts with a temporal array
    @inbounds while k < j <= finish

        if array[j] < temp[i]
            array[k] = array[j]
            j += 1
        else
            array[k] = temp[i]
            i += 1
        end
        k += 1
    end
    @inbounds while k < j
        array[k] = temp[i]
        k += 1
        i += 1
    end
    return array
end


totalNumbers = 1000;
list = [rem(rand(Int64),100) for i =1:totalNumbers]
#JULIA_NUM_THREADS = 5
@time print(mergesort_parallel!(list));
#@time mergesort_parallel!(list);
#@time @spawn psort!(vectorDisorderly);
