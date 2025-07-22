// SPDX-License-Identifier: AGPL-3.0-only

/**
 *   IStaking.sol - fair-manager
 *   Copyright (C) 2025-Present SKALE Labs
 *   @author Dmytro Stebaiev
 *
 *   fair-manager is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU Affero General Public License as published
 *   by the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   fair-manager is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Affero General Public License for more details.
 *
 *   You should have received a copy of the GNU Affero General Public License
 *   along with fair-manager.  If not, see <https://www.gnu.org/licenses/>.
 */

pragma solidity ^0.8.24;

import {ICommittee} from "./ICommittee.sol";
import {INodes, NodeId} from "./INodes.sol";
import {IRewardWallet} from "./IRewardWallet.sol";
import {Fair} from "./units.sol";


interface IStaking {
    receive() external payable;
    function initialize(
        address initialAuthority,
        ICommittee committee,
        INodes nodes,
        IRewardWallet rewardWalletReference
    ) external;
    function claimAllFee(address payable to) external;
    function claimFee(address payable to, Fair amount) external;
    function disable(NodeId node) external;
    function enable(NodeId node) external;
    function nodeCreated(NodeId node) external;
    function payReward(NodeId node) external payable;
    function retrieve(NodeId node, Fair value) external;
    function setFeeRate(uint16 feeRate) external;
    function setRewardWalletReference(IRewardWallet rewardWalletReference_) external;
    function stake(NodeId node) external payable;
    function getEarnedFeeAmount(NodeId node) external view returns (Fair amount);
    function getNodeShare(NodeId node) external view returns (uint256 share);
    function getRewardWallet(NodeId node) external view returns (IRewardWallet rewardWallet);
    function getStakedAmount() external view returns (Fair amount);
    function getStakedAmountFor(address holder) external view returns (Fair amount);
    function getStakedNodes() external view returns (NodeId[] memory nodes);
    function getStakedNodesFor(address holder) external view returns (NodeId[] memory stakedNodes);
    function getStakedToNodeAmount(NodeId node) external view returns (Fair amount);
    function getStakedToNodeAmountFor(NodeId node, address holder) external view returns (Fair amount);
}
