def is_cmd_allowed(pcmd, window, from_socket, extra_data):
    cmd_name = pcmd['cmd']
    cmd_payload = pcmd['payload']

    print('name: ', cmd_name)
    print('payload: ', cmd_payload)
    print('window: ', window)
    print('from_socket?: ', from_socket)
    print('extra_data: ', extra_data)

    return True
