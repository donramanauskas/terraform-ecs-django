
def fibonnaci_calculator(n):
    """
    This probably should be refactoed to use list comprehension, to run more effectively.
    :param n: integer number
    :return: [0, 1, 1, 2, 3]
    """

    count = 0
    n1 = 0
    n2 = 1
    result = []

    if n == 0:
        return [0]
    elif n == 1:
        return [0, 1]
    else:
        while count < n:
            result.append(n1)
            nth = n1 + n2
            n1 = n2
            n2 = nth
            count += 1

    return result