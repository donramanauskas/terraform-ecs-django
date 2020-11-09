from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response

from .fibonaci_calculator import fibonnaci_calculator


class FibonacciView(APIView):

    def get(self, request):
        return Response({"test_field: Velcome to Fibonacci API app", status.HTTP_200_OK})

    def post(self, request):
        try:
            number = int(request.data.get('number'))
        except:
            return Response({status.HTTP_403_FORBIDDEN,
                             """error: Could not convert number in the request to int,
                             make sure you are using valid integer number values"""})

        if number < 0:
            return Response({status.HTTP_403_FORBIDDEN,
                             "error: Fibonacci sequence can not be calculated for negative numbers"})

        result = fibonnaci_calculator(number)
        return Response(result)